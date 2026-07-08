import { Trip } from '../model/HangLvTravelModels'

@ComponentV2
export struct TripCard {
  @Param trip: Trip = new Trip()
  @Event onCancel: (id: string) => void = (id: string) => {}

  build() {
    Column() {
      Row() {
        Text(this.trip.status === '已出行' ? '✅' : '📋')
          .fontSize(22)
        Column() {
          Text(`行程 ${this.trip.id}`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
          Text(`预订日期: ${this.trip.bookDate}`)
            .fontSize(12)
            .fontColor('#999')
          Text(`乘车人: ${this.trip.passengers.join('、')}`)
            .fontSize(12)
            .fontColor('#999')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10 })
        .layoutWeight(1)
        Text(this.trip.status)
          .fontSize(12)
          .fontColor(this.trip.status === '已出行' ? '#999' : '#FF6600')
      }
      .width('100%')

      if (this.trip.status === '已预订') {
        Row() {
          Text('改签')
            .fontSize(12)
            .fontColor('#666')
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .backgroundColor('#F0F0F0')
            .borderRadius(4)
            .margin({ right: 8 })
            .onClick(() => {})
          Text('取消订单')
            .fontSize(12)
            .fontColor('#FF4444')
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .backgroundColor('#FFF0F0')
            .borderRadius(4)
            .onClick(() => {
              this.onCancel(this.trip.id)
            })
        }
        .width('100%')
        .margin({ top: 8 })
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
  }
}
