import { ScheduleEvent, UserStatus } from '../model/YouLinkModels'
import { YouLinkMock } from '../mock/YouLinkMock'
import { ScheduleCard } from '../view/ScheduleCard'
import { StatusSelector } from '../view/StatusSelector'
import { QuickActions } from '../view/QuickActions'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local schedule: ScheduleEvent[] = YouLinkMock.getTodaySchedule()
  @Local currentStatus: string = '在线'
  @Local statusOptions: UserStatus[] = YouLinkMock.getStatusOptions()

  build() {
    Column() {
      Text('YouLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 4 })

      Column() {
        Row() {
          Text('🟢')
            .fontSize(24)
          Column() {
            Text('小李')
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
            Text(`当前状态: ${this.currentStatus}`)
              .fontSize(12)
              .fontColor('#666')
          }
          .margin({ left: 10 })
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(14)
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 12 })
      .borderRadius(8)

      StatusSelector({
        options: this.statusOptions,
        current: this.currentStatus,
        onSelect: (status: UserStatus) => {
          this.currentStatus = status.label
          promptAction.showToast({ message: `状态已切换为${status.label}` })
        }
      })

      QuickActions({
        onLeave: () => { router.pushUrl({ url: 'pages/LeaveStatus' }) },
        onAutoReply: () => { promptAction.showToast({ message: '已开启自动回复' }) },
        onUpdateStatus: () => { promptAction.showToast({ message: '状态已更新' }) }
      })

      Row() {
        Text('💬')
          .fontSize(20)
          .margin({ right: 8 })
        Text('Bot 对话')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
        Image($r('sys.media.ohos_ic_public_arrow_right'))
          .width(16)
          .height(16)
          .fillColor('#CCC')
      }
      .width('100%')
      .padding(14)
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 8 })
      .borderRadius(8)
      .onClick(() => {
        router.pushUrl({ url: 'pages/ChatPage' })
      })

      Text('今日日程')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 10, bottom: 4 })

      List() {
        ForEach(this.schedule, (event: ScheduleEvent) => {
          ListItem() {
            ScheduleCard({ event: event })
          }
        })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 8 })
      .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
