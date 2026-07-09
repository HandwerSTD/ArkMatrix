import { liveViewManager } from '@kit.LiveViewKit'
import { BaseLiveViewManager } from './BaseLiveViewManager'

export enum NavigationStatus {
  NAVIGATION_START = 1,
  GUIDE_ONE = 2,
  ROUTE_CHANGE = 3,
  GUIDE_TWO = 4,
  NAVIGATION_END = 5
}

export interface NavigationDirection {
  action: string
  distance: number
  distanceUnit: string
  destination: string
  currentIcon: string
  navigationIcons: string[]
  capsuleIcon: string
}

export class NavigationLiveViewManager extends BaseLiveViewManager {
  private destinationName: string = ''
  private static readonly CONTENT_COLOR: string = '#FF0A59F7'
  private static readonly CAPSULE_COLOR: string = '#FF308977'

  constructor(bundleName: string, abilityName: string) {
    super(bundleName, abilityName)
  }

  async start(destination: string = '目的地'): Promise<void> {
    this.destinationName = destination
    await super.start()
  }

  async updateDirection(direction: NavigationDirection): Promise<void> {
    if (this.view === undefined) {
      console.warn(`updateDirection, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      const title: string = `${direction.distance}${direction.distanceUnit}后${direction.action}`
      this.view.liveViewData.primary.title = title
      this.view.liveViewData.primary.content = [
        { text: `去往 ${direction.destination}` }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_NAVIGATION,
        currentNavigationIcon: direction.currentIcon,
        navigationIcons: direction.navigationIcons
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: direction.capsuleIcon,
        backgroundColor: NavigationLiveViewManager.CAPSULE_COLOR,
        title: `${direction.distance} ${direction.distanceUnit}`
      }
      console.info(`updateDirection req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`updateDirection error: ${err.code}, ${err.message}`)
    }
  }

  async routeReroute(direction: NavigationDirection): Promise<void> {
    if (this.view === undefined) {
      console.warn(`routeReroute, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      const title: string = `${direction.distance}${direction.distanceUnit}后${direction.action}`
      this.view.liveViewData.primary.title = title
      this.view.liveViewData.primary.content = [
        { text: `重新规划路线 | 去往${direction.destination}` }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_NAVIGATION,
        currentNavigationIcon: direction.currentIcon,
        navigationIcons: direction.navigationIcons
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: direction.capsuleIcon,
        backgroundColor: NavigationLiveViewManager.CAPSULE_COLOR,
        title: `${direction.distance} ${direction.distanceUnit}`
      }
      console.info(`routeReroute req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`routeReroute error: ${err.code}, ${err.message}`)
    }
  }

  async complete(): Promise<void> {
    if (this.view === undefined) {
      console.warn(`complete, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.liveViewData.primary.title = '导航结束'
      this.view.liveViewData.primary.content = [
        { text: '祝您一路顺风' }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_DEFAULT
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
      id: 400,
      event: 'NAVIGATION',
      sequence: NavigationStatus.NAVIGATION_START,
      isMute: false,
      liveViewData: {
        primary: {
          title: '开始导航',
          content: [
            { text: '去往 ' },
            { text: this.destinationName, textColor: NavigationLiveViewManager.CONTENT_COLOR }
          ],
          keepTime: 15,
          clickAction: await this.buildWantAgent('Navigation'),
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_NAVIGATION,
            currentNavigationIcon: 'arrow_up.png',
            navigationIcons: ['arrow_up.png', 'arrow_up.png', 'arrow_up.png', 'arrow_right.png']
          }
        },
        capsule: {
          type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
          status: 1,
          icon: 'capsule_up.png',
          backgroundColor: NavigationLiveViewManager.CAPSULE_COLOR,
          title: `去往 ${this.destinationName}`
        },
        external: {
          title: '导航',
          content: [{ text: `前往 ${this.destinationName}` }],
          type: 0,
          backgroundColor: '#000000',
          backgroundPicture: ''
        }
      }
    }
  }
}
