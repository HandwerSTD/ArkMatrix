import { liveViewManager } from '@kit.LiveViewKit'
import { BaseLiveViewManager } from './BaseLiveViewManager'

export enum TaxiStatus {
  CALLING = 1,
  ABOUT_TO_BEGIN = 2,
  DRIVER_ON_THE_WAY = 3,
  DRIVER_ARRIVE = 4,
  HEADING_TO_DESTINATION = 5,
  COMPLETED = 6,
  WAIT_PAYMENT = 7,
  ORDER_COMPLETED = 8
}

export interface TaxiDriverInfo {
  plate: string
  driverName: string
  carModel: string
}

export interface TaxiPaymentInfo {
  amount: string
}

export class TaxiLiveViewManager extends BaseLiveViewManager {
  private static readonly CONTENT_COLOR: string = '#FF0A59F7'
  private static readonly UNDER_LINE_COLOR: string = '#FF0A59F7'
  private static readonly CAPSULE_COLOR: string = '#FF308977'

  constructor(bundleName: string, abilityName: string) {
    super(bundleName, abilityName)
  }

  async driverAccepted(info: TaxiDriverInfo): Promise<void> {
    await this.updateToStatus(TaxiStatus.ABOUT_TO_BEGIN, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.isMute = false
      this.view.liveViewData.primary.title = '行程即将开始'
      this.view.liveViewData.primary.content = [
        { text: '预计5分钟后到达指定地点 ' }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PICKUP,
        title: '车牌号',
        content: info.plate,
        underlineColor: TaxiLiveViewManager.UNDER_LINE_COLOR,
        descPic: 'aito_m5.png'
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_taxi.png',
        backgroundColor: TaxiLiveViewManager.CAPSULE_COLOR,
        title: '已接单'
      }
    })
  }

  async driverOnTheWay(): Promise<void> {
    await this.updateToStatus(TaxiStatus.DRIVER_ON_THE_WAY, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.liveViewData.primary.title = '司机正在赶来'
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_gps.png',
        backgroundColor: TaxiLiveViewManager.CAPSULE_COLOR,
        title: '接驾中'
      }
    })
  }

  async driverArrived(info: TaxiDriverInfo): Promise<void> {
    await this.updateToStatus(TaxiStatus.DRIVER_ARRIVE, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.liveViewData.primary.title = '司机已到达上车点'
      this.view.liveViewData.primary.content = [
        { text: `${info.carModel}丨${info.driverName}` }
      ]
    })
  }

  async headingToDestination(): Promise<void> {
    await this.updateToStatus(TaxiStatus.HEADING_TO_DESTINATION, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.isMute = true
      this.view.liveViewData.primary.title = '正在去往目的地'
      this.view.liveViewData.primary.content = [
        { text: '预计达到目的地时间：' },
        { text: '23:49', textColor: TaxiLiveViewManager.CONTENT_COLOR }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
        progress: 0,
        lineType: liveViewManager.LineType.LINE_TYPE_DOTTED_LINE,
        indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_UP,
        indicatorIcon: 'taxi-transport-icon.png',
        nodeIcons: ['icon_order.png', 'icon_finish.png']
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_taxi.png',
        backgroundColor: TaxiLiveViewManager.CAPSULE_COLOR,
        title: '行程中'
      }
    })
  }

  async tripCompleted(): Promise<void> {
    await this.updateToStatus(TaxiStatus.COMPLETED, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.liveViewData.primary.title = '行程结束'
      this.view.liveViewData.primary.content = [
        { text: '乘客已送达' }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
        progress: 100,
        lineType: liveViewManager.LineType.LINE_TYPE_DOTTED_LINE,
        indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_UP,
        indicatorIcon: 'taxi-transport-icon.png',
        nodeIcons: ['icon_order.png', 'icon_finish.png']
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_taxi.png',
        backgroundColor: TaxiLiveViewManager.CAPSULE_COLOR,
        title: '行程结束'
      }
    })
  }

  async waitPayment(info: TaxiPaymentInfo): Promise<void> {
    await this.updateToStatus(TaxiStatus.WAIT_PAYMENT, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.liveViewData.primary.title = '待支付'
      this.view.liveViewData.primary.content = [
        { text: '已到达指定地点，待支付' }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PICKUP,
        title: '待支付金额',
        content: info.amount,
        underlineColor: TaxiLiveViewManager.UNDER_LINE_COLOR,
        descPic: 'aito_m5.png'
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_store.png',
        backgroundColor: TaxiLiveViewManager.CAPSULE_COLOR,
        title: '待支付'
      }
    })
  }

  async orderCompleted(): Promise<void> {
    await this.updateToStatus(TaxiStatus.ORDER_COMPLETED, async (): Promise<void> => {
      await this.stop()
    })
  }

  async updateProgress(progress: number, remainingTime: string): Promise<void> {
    if (this.view === undefined) {
      console.warn(`updateProgress, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.liveViewData.primary.content = [
        { text: '预计达到目的地时间：' },
        { text: remainingTime, textColor: TaxiLiveViewManager.CONTENT_COLOR }
      ]
      if (this.view.liveViewData.primary.layoutData !== undefined) {
        this.view.liveViewData.primary.layoutData = {
          layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
          progress: progress,
          lineType: liveViewManager.LineType.LINE_TYPE_DOTTED_LINE,
          indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_UP,
          indicatorIcon: 'taxi-transport-icon.png',
          nodeIcons: ['icon_order.png', 'icon_finish.png']
        }
      }
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`updateProgress error: ${err.code}, ${err.message}`)
    }
  }

  private async updateToStatus(status: TaxiStatus, updateFn: () => void | Promise<void>): Promise<void> {
    if (this.view === undefined) {
      console.warn(`updateToStatus, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.sequence = status
      const result = updateFn()
      if (result instanceof Promise) {
        await result
      }
      if (this.view === undefined || status === TaxiStatus.ORDER_COMPLETED) {
        return
      }
      console.info(`updateToStatus req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`updateToStatus error: ${err.code}, ${err.message}`)
    }
  }

  protected async buildDefaultView(): Promise<liveViewManager.LiveView> {
    return {
      id: 200,
      event: 'TAXI',
      sequence: TaxiStatus.CALLING,
      liveViewData: {
        primary: {
          title: '呼叫车辆中',
          content: [
            { text: '正在召唤司机，预计三分钟内接单' }
          ],
          keepTime: 15,
          clickAction: await this.buildWantAgent('TaxiHailing'),
          extensionData: {
            type: liveViewManager.ExtensionType.EXTENSION_TYPE_ICON,
            pic: 'icon_taxi.png',
            clickAction: await this.buildWantAgent('TaxiHailing')
          },
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_DEFAULT
          }
        },
        capsule: {
          type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
          status: 1,
          icon: 'capsule_gps.png',
          backgroundColor: TaxiLiveViewManager.CAPSULE_COLOR,
          title: '待接单'
        },
        external: {
          title: '出行打车',
          content: [{ text: '正在呼叫车辆...' }],
          type: 0,
          backgroundColor: '#000000',
          backgroundPicture: ''
        }
      }
    }
  }
}
