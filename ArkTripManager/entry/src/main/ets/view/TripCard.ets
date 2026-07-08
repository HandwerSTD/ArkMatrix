import { Trip } from '../model/TripModels'

@ComponentV2
export struct TripCard {
  @Param trip: Trip = new Trip()
  @Event onClick: (id: string) => void = (id: string) => {}

  build() {
    Column() {
      Row() {
        Text(this.trip.cover)
          .fontSize(36)
          .width(56)
          .height(56)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)
          .textAlign(TextAlign.Center)
        Column() {
          Text(this.trip.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
          Text(`${this.trip.startDate} ~ ${this.trip.endDate}`)
            .fontSize(12)
            .fontColor('#999')
            .margin({ top: 2 })
          Row() {
            Text(`📍 ${this.trip.destination}`)
              .fontSize(12)
              .fontColor('#666')
            Text(`  📋 ${this.trip.dailyPlans.length}天行程`)
              .fontSize(12)
              .fontColor('#666')
              .margin({ left: 6 })
          }
          .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
        .layoutWeight(1)
        Text(this.trip.status)
          .fontSize(12)
          .fontColor(this.trip.status === '进行中' ? '#FF6600' : this.trip.status === '已完成' ? '#999' : '#44BB44')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .margin({ bottom: 12 })
    .onClick(() => {
      this.onClick(this.trip.id)
    })
  }
}
