import { liveViewManager } from '@kit.LiveViewKit'
import { BaseLiveViewManager } from './BaseLiveViewManager'

export enum WorkoutStatus {
  WORKOUT_START = 1,
  WORKOUT_PROCESS_ONE = 2,
  WORKOUT_PROCESS_TWO = 3,
  WORKOUT_PROCESS_THREE = 4,
  WORKOUT_END = 5
}

export interface WorkoutProgress {
  remainingDistance: string
  targetDistance: string
  duration: string
}

export class WorkoutLiveViewManager extends BaseLiveViewManager {
  private targetDistance: string = '5km'
  private static readonly PROCESS_COLOR: string = '#ff10c1f7'
  private static readonly CAPSULE_COLOR: string = '#FF308977'
  private static readonly UNDER_LINE_COLOR: string = '#FF0A59F7'

  constructor(bundleName: string, abilityName: string) {
    super(bundleName, abilityName)
  }

  async start(targetDistance: string = '5km'): Promise<void> {
    this.targetDistance = targetDistance
    await super.start()
  }

  async updateProgress(remaining: string): Promise<void> {
    if (this.view === undefined) {
      console.warn(`updateProgress, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.liveViewData.primary.content = [
        { text: '剩余距离' },
        { text: ` ${remaining}`, textColor: WorkoutLiveViewManager.PROCESS_COLOR },
        { text: ' | ' },
        { text: '运动目标' },
        { text: ` ${this.targetDistance}`, textColor: WorkoutLiveViewManager.PROCESS_COLOR }
      ]
      console.info(`updateProgress req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`updateProgress error: ${err.code}, ${err.message}`)
    }
  }

  async pause(): Promise<void> {
    if (this.view === undefined) {
      console.warn(`pause, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.timer = { isPaused: true }
      this.view.liveViewData.primary.title = '运动已暂停'
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
        status: 1,
        isPaused: true
      }
      console.info(`pause req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`pause error: ${err.code}, ${err.message}`)
    }
  }

  async resume(): Promise<void> {
    if (this.view === undefined) {
      console.warn(`resume, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.timer = { isPaused: false }
      this.view.liveViewData.primary.title = '运动中'
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
        status: 1,
        isPaused: false
      }
      console.info(`resume req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`resume error: ${err.code}, ${err.message}`)
    }
  }

  async complete(remaining: string): Promise<void> {
    if (this.view === undefined) {
      console.warn(`complete, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.liveViewData.primary.title = '运动结束'
      this.view.liveViewData.primary.content = [
        { text: '已完成目标' },
        { text: ` ${this.targetDistance}`, textColor: WorkoutLiveViewManager.PROCESS_COLOR }
      ]
      this.view.timer = { isPaused: true }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
        status: 1,
        isPaused: true
      }
      console.info(`complete req: ${JSON.stringify(this.view)}`)
      await liveViewManager.stopLiveView(this.view)
      this.view = undefined
      this.currentSequence = 1
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`complete error: ${err.code}, ${err.message}`)
    }
  }

  protected async buildDefaultView(): Promise<liveViewManager.LiveView> {
    return {
      id: 300,
      event: 'WORKOUT',
      sequence: WorkoutStatus.WORKOUT_START,
      isMute: false,
      timer: {
        time: 0,
        isCountdown: false,
        isPaused: false
      },
      liveViewData: {
        primary: {
          title: '运动中',
          content: [
            { text: '剩余距离' },
            { text: ` ${this.targetDistance}`, textColor: WorkoutLiveViewManager.PROCESS_COLOR },
            { text: ' | ' },
            { text: '运动目标' },
            { text: ` ${this.targetDistance}`, textColor: WorkoutLiveViewManager.PROCESS_COLOR }
          ],
          keepTime: 15,
          clickAction: await this.buildWantAgent('Workout'),
          extensionData: {
            type: liveViewManager.ExtensionType.EXTENSION_TYPE_ICON,
            pic: 'sport_extension.png',
            clickAction: await this.buildWantAgent('Workout')
          },
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PICKUP,
            title: '运动时长',
            content: '${placeholder.timer}',
            underlineColor: WorkoutLiveViewManager.UNDER_LINE_COLOR,
            descPic: 'workout.png'
          }
        },
        capsule: {
          type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
          status: 1,
          icon: 'workout.png',
          backgroundColor: WorkoutLiveViewManager.CAPSULE_COLOR,
          time: 0,
          isCountdown: false,
          isPaused: false
        },
        external: {
          title: '运动锻炼',
          content: [{ text: `目标 ${this.targetDistance}` }],
          type: 0,
          backgroundColor: '#000000',
          backgroundPicture: ''
        }
      }
    }
  }
}
