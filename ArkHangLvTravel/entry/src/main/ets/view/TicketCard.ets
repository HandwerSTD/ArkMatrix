import { Ticket } from '../model/HangLvTravelModels'

@ComponentV2
export struct TicketCard {
  @Param ticket: Ticket = new Ticket()
  @Event onBook: (id: string) => void = (id: string) => {}
  @Event onSubscribe: (id: string, value: boolean) => void = (id: string, value: boolean) => {}

  build() {
    Column() {
      Row() {
        Text(this.ticket.type === '高铁' ? '🚄' : '✈️')
          .fontSize(28)
        Column() {
          Text(this.ticket.trainNo)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
        }
        .margin({ left: 8 })
        .alignItems(HorizontalAlign.Start)
        Blank()
        Text(`¥${this.ticket.price}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6600')
      }
      .width('100%')

      Row() {
        Column() {
          Text(this.ticket.departTime)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text(this.ticket.departure)
            .fontSize(12)
            .fontColor('#999')
        }
        Column() {
          Text(this.ticket.duration)
            .fontSize(12)
            .fontColor('#666')
          Divider()
            .width(60)
            .height(1)
            .color('#CCC')
        }
        .margin({ left: 15, right: 15 })
        .alignItems(HorizontalAlign.Center)
        Column() {
          Text(this.ticket.arriveTime)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text(this.ticket.arrival)
            .fontSize(12)
            .fontColor('#999')
        }
      }
      .width('100%')
      .margin({ top: 10 })
      .justifyContent(FlexAlign.Center)

      if (this.ticket.delay.length > 0) {
        Row() {
          Text('⚠️')
            .fontSize(14)
          Text(this.ticket.delay)
            .fontSize(12)
            .fontColor('#FF4444')
        }
        .width('100%')
        .padding(8)
        .backgroundColor('#FFF0F0')
        .borderRadius(4)
        .margin({ top: 8 })
      }

      Row() {
        Text(this.ticket.isSubscribed ? '已订阅延误提醒' : '订阅延误提醒')
          .fontSize(12)
          .fontColor(this.ticket.isSubscribed ? '#999' : '#666')
          .onClick(() => {
            this.onSubscribe(this.ticket.id, !this.ticket.isSubscribed)
          })
        Blank()
        if (!this.ticket.isBooked) {
          Button('预订')
            .fontSize(13)
            .height(32)
            .borderRadius(16)
            .backgroundColor('#FF6600')
            .fontColor(Color.White)
            .onClick(() => {
              this.onBook(this.ticket.id)
            })
        } else {
          Text('已预订')
            .fontSize(13)
            .fontColor('#44BB44')
        }
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 10 })
  }
}
