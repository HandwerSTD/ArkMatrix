import { liveViewManager } from '@kit.LiveViewKit'
import { Want, wantAgent, WantAgent } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'

export class BaseLiveViewManager {
  protected view: liveViewManager.LiveView | undefined = undefined
  protected bundleName: string = ''
  protected abilityName: string = ''
  protected currentSequence: number = 1

  constructor(bundleName: string, abilityName: string) {
    this.bundleName = bundleName
    this.abilityName = abilityName
  }

  async start(): Promise<void> {
    const enabled: boolean = await BaseLiveViewManager.isLiveViewEnabled()
    if (!enabled) {
      console.warn(`startLiveView, live view is disabled.`)
      return
    }
    this.currentSequence = 1
    this.view = await this.buildDefaultView()
    try {
      console.info(`startLiveView req: ${JSON.stringify(this.view)}`)
      const result = await liveViewManager.startLiveView(this.view)
      console.info(`startLiveView result: ${JSON.stringify(result)}`)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`startLiveView error: ${err.code}, ${err.message}`)
    }
  }

  async stop(): Promise<void> {
    try {
      const enabled: boolean = await BaseLiveViewManager.isLiveViewEnabled()
      if (!enabled || this.view === undefined) {
        console.warn(`stopLiveView, live view is disabled.`)
        return
      }
      if (this.view.sequence !== undefined) {
        this.view.sequence += 1
      }
      console.info(`stopLiveView req: ${JSON.stringify(this.view)}`)
      const result = await liveViewManager.stopLiveView(this.view)
      console.info(`stopLiveView result: ${JSON.stringify(result)}`)
      this.view = undefined
      this.currentSequence = 1
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`stopLiveView error: ${err.code}, ${err.message}`)
    }
  }

  isActive(): boolean {
    return this.view !== undefined
  }

  protected async incrementSequence(): Promise<void> {
    if (this.view !== undefined && this.view.sequence !== undefined) {
      this.view.sequence += 1
      this.currentSequence += 1
    }
  }

  static async isLiveViewEnabled(): Promise<boolean> {
    let result: boolean = false
    try {
      result = await liveViewManager.isLiveViewEnabled()
    } catch (e) {
      console.error(`isLiveViewEnabled error: ${JSON.stringify(e)}`)
    }
    console.info(`isLiveViewEnabled result: ${result}`)
    return result
  }

  protected async buildWantAgent(page: string): Promise<Want> {
    const wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: this.bundleName,
          abilityName: this.abilityName,
          parameters: { page: page }
        } as Want
      ],
      actionType: wantAgent.OperationType.START_ABILITIES,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
    }
    try {
      const agent: WantAgent = await wantAgent.getWantAgent(wantAgentInfo)
      console.info(`getWantAgent success!`)
      return agent
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`getWantAgent failed! err: ${err.code}, ${err.message}`)
      throw e as Error
    }
  }

  protected async buildDefaultView(): Promise<liveViewManager.LiveView> {
    return {} as liveViewManager.LiveView
  }
}
