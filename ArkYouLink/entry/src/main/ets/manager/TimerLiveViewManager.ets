import { liveViewManager } from '@kit.LiveViewKit'
import { BaseLiveViewManager } from './BaseLiveViewManager'

enum TimerStatus {
  STARTED = 1,
  PAUSED = 2,
  RESUMED = 3,
  COMPLETED = 4
}

export class TimerLiveViewManager extends BaseLiveViewManager {
  private isCountdown: boolean = false
  private timerMinutes: number = 25
  private timerTitle: string = '计时中'
  private static readonly CAPSULE_COLOR: string = '#FF308977'
  private static readonly PICKUP_COLOR: string = '#FF0A59F7'

  constructor(bundleName: string, abilityName: string) {
    super(bundleName, abilityName)
  }

  async start(countdownMinutes: number = 25, title: string = '计时中', isCountdown: boolean = true): Promise<void> {
    this.isCountdown = isCountdown
    this.timerMinutes = countdownMinutes
    this.timerTitle = title
    await super.start()
  }

  async pause(): Promise<void> {
    if (this.view === undefined) {
      console.warn(`pauseTimer, no active live view.`)
      return
    }
    try {
      this.view.timer = { isPaused: true }
      this.view.liveViewData.primary.title = '已暂停'
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
        status: 1,
        isPaused: true
      }
      await this.incrementSequence()
      console.info(`pauseTimer req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`pauseTimer error: ${err.code}, ${err.message}`)
    }
  }

  async resume(): Promise<void> {
    if (this.view === undefined) {
      console.warn(`resumeTimer, no active live view.`)
      return
    }
    try {
      this.view.timer = { isPaused: false }
      this.view.liveViewData.primary.title = this.timerTitle
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
        status: 1,
        isPaused: false
      }
      await this.incrementSequence()
      console.info(`resumeTimer req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`resumeTimer error: ${err.code}, ${err.message}`)
    }
  }

  protected async buildDefaultView(): Promise<liveViewManager.LiveView> {
    const timeMs: number = this.timerMinutes * 60 * 1000
    return {
      id: 100,
      event: 'TIMER',
      sequence: TimerStatus.STARTED,
      isMute: false,
      timer: {
        time: this.isCountdown ? timeMs : 0,
        isCountdown: this.isCountdown,
        isPaused: false
      },
      liveViewData: {
        primary: {
          title: this.timerTitle,
          content: [
            { text: '计时实况窗' }
          ],
          keepTime: 15,
          clickAction: await this.buildWantAgent('Timer'),
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PICKUP,
            title: '计时时间',
            content: '${placeholder.timer}',
            underlineColor: TimerLiveViewManager.PICKUP_COLOR,
            descPic: 'timer.png'
          },
          extensionData: {
            type: liveViewManager.ExtensionType.EXTENSION_TYPE_DEFAULT
          }
        },
        capsule: {
          type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
          status: 1,
          icon: 'capsule_timer.png',
          backgroundColor: TimerLiveViewManager.CAPSULE_COLOR,
          time: this.isCountdown ? timeMs : 0,
          isCountdown: this.isCountdown,
          isPaused: false
        },
        external: {
          title: this.timerTitle,
          content: [{ text: this.isCountdown ? `倒计时 ${this.timerMinutes} 分钟` : '正计时中' }],
          type: 0,
          backgroundColor: '#000000',
          backgroundPicture: ''
        }
      }
    }
  }
}
