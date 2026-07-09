import { liveViewManager } from '@kit.LiveViewKit'
import { BaseLiveViewManager } from './BaseLiveViewManager'

export enum DeliveryStatus {
  WAITING_MERCHANT = 1,
  MERCHANT_ACCEPTED = 2,
  MERCHANT_PREPARING = 3,
  RIDER_PICKUP = 4,
  DELIVERING = 5,
  ARRIVING = 6,
  COMPLETED = 7
}

export interface DeliveryProgress {
  statusText: string
  progress: number
  remainingTime: string
}

export class DeliveryLiveViewManager extends BaseLiveViewManager {
  private orderTitle: string = '外卖配送'
  private static readonly CONTENT_COLOR: string = '#FF0A59F7'
  private static readonly UNDER_LINE_COLOR: string = '#FF0A59F7'
  private static readonly CAPSULE_COLOR: string = '#FF308977'

  constructor(bundleName: string, abilityName: string) {
    super(bundleName, abilityName)
  }

  async start(orderTitle: string = '外卖配送'): Promise<void> {
    this.orderTitle = orderTitle
    await super.start()
  }

  async merchantAccepted(): Promise<void> {
    await this.updateToStatus(DeliveryStatus.MERCHANT_ACCEPTED, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.isMute = false
      this.view.liveViewData.primary.title = '商家已接单'
      this.view.liveViewData.primary.content = [
        { text: '商家正在准备您的订单' }
      ]
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_store.png',
        backgroundColor: DeliveryLiveViewManager.CAPSULE_COLOR,
        title: '已接单'
      }
    })
  }

  async merchantPreparing(remainingTime: string = '预计15分钟'): Promise<void> {
    await this.updateToStatus(DeliveryStatus.MERCHANT_PREPARING, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.liveViewData.primary.title = '商家备货中'
      this.view.liveViewData.primary.content = [
        { text: `预计出餐时间: ` },
        { text: remainingTime, textColor: DeliveryLiveViewManager.CONTENT_COLOR }
      ]
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_store.png',
        backgroundColor: DeliveryLiveViewManager.CAPSULE_COLOR,
        title: '备货中'
      }
    })
  }

  async riderPickup(riderName: string = '骑手', plate: string = ''): Promise<void> {
    await this.updateToStatus(DeliveryStatus.RIDER_PICKUP, (): void => {
      if (this.view === undefined) {
        return
      }
      let pickText: string = `${riderName}已取餐`
      if (plate.length > 0) {
        pickText = `${riderName}已取餐，${plate}`
      }
      this.view.liveViewData.primary.title = '骑手已取餐'
      this.view.liveViewData.primary.content = [
        { text: pickText }
      ]
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_rider.png',
        backgroundColor: DeliveryLiveViewManager.CAPSULE_COLOR,
        title: '取餐中'
      }
    })
  }

  async delivering(riderName: string = '骑手'): Promise<void> {
    await this.updateToStatus(DeliveryStatus.DELIVERING, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.isMute = true
      this.view.liveViewData.primary.title = '配送中'
      this.view.liveViewData.primary.content = [
        { text: `${riderName}正在为您配送` }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
        progress: 50,
        lineType: liveViewManager.LineType.LINE_TYPE_DOTTED_LINE,
        indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_DOWN,
        indicatorIcon: 'rider-icon.png',
        nodeIcons: ['icon_store.png', 'icon_home.png']
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_rider.png',
        backgroundColor: DeliveryLiveViewManager.CAPSULE_COLOR,
        title: '配送中'
      }
    })
  }

  async arriving(): Promise<void> {
    await this.updateToStatus(DeliveryStatus.ARRIVING, (): void => {
      if (this.view === undefined) {
        return
      }
      this.view.liveViewData.primary.title = '即将送达'
      this.view.liveViewData.primary.content = [
        { text: '骑手即将到达，请准备接收' }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
        progress: 90,
        lineType: liveViewManager.LineType.LINE_TYPE_DOTTED_LINE,
        indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_DOWN,
        indicatorIcon: 'rider-icon.png',
        nodeIcons: ['icon_store.png', 'icon_home.png']
      }
      this.view.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        icon: 'capsule_rider.png',
        backgroundColor: DeliveryLiveViewManager.CAPSULE_COLOR,
        title: '即将送达'
      }
    })
  }

  async delivered(): Promise<void> {
    await this.updateToStatus(DeliveryStatus.COMPLETED, async (): Promise<void> => {
      await this.stop()
    })
  }

  async updateDeliveryProgress(progress: number, statusText: string, remainingTime: string): Promise<void> {
    if (this.view === undefined) {
      console.warn(`updateDeliveryProgress, no active live view.`)
      return
    }
    try {
      await this.incrementSequence()
      this.view.liveViewData.primary.content = [
        { text: statusText }
      ]
      this.view.liveViewData.primary.layoutData = {
        layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PROGRESS,
        progress: progress,
        lineType: liveViewManager.LineType.LINE_TYPE_NORMAL_SOLID_LINE,
        indicatorType: liveViewManager.IndicatorType.INDICATOR_TYPE_DOWN,
        indicatorIcon: 'rider-icon.png',
        nodeIcons: ['icon_store.png', 'icon_home.png']
      }
      console.info(`updateDeliveryProgress req: ${JSON.stringify(this.view)}`)
      await liveViewManager.updateLiveView(this.view)
    } catch (e) {
      const err: BusinessError = e as BusinessError
      console.error(`updateDeliveryProgress error: ${err.code}, ${err.message}`)
    }
  }

  private async updateToStatus(status: DeliveryStatus, updateFn: () => void | Promise<void>): Promise<void> {
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
      if (this.view === undefined || status === DeliveryStatus.COMPLETED) {
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
      id: 500,
      event: 'DELIVERY',
      sequence: DeliveryStatus.WAITING_MERCHANT,
      isMute: true,
      liveViewData: {
        primary: {
          title: this.orderTitle,
          content: [
            { text: '等待商家接单' }
          ],
          keepTime: 15,
          clickAction: await this.buildWantAgent('Delivery'),
          extensionData: {
            type: liveViewManager.ExtensionType.EXTENSION_TYPE_ICON,
            pic: 'icon_delivery.png',
            clickAction: await this.buildWantAgent('Delivery')
          },
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_DEFAULT
          }
        },
        capsule: {
          type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
          status: 1,
          icon: 'capsule_store.png',
          backgroundColor: DeliveryLiveViewManager.CAPSULE_COLOR,
          title: '等待接单'
        },
        external: {
          title: this.orderTitle,
          content: [{ text: '等待商家接单' }],
          type: 0,
          backgroundColor: '#000000',
          backgroundPicture: ''
        }
      }
    }
  }
}
