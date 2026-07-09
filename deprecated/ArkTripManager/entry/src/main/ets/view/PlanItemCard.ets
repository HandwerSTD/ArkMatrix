import { PlanItem } from '../model/TripModels'

@ComponentV2
export struct PlanItemCard {
  @Param item: PlanItem = new PlanItem()
  @Event onDelete: (itemIdx: number) => void = (itemIdx: number) => {}

  build() {
    Row() {
      Column() {
        Text(this.item.time)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6600')
        if (this.item.note.length > 0) {
          Text(this.item.note)
            .fontSize(10)
            .fontColor('#999')
            .maxLines(1)
        }
      }
      .alignItems(HorizontalAlign.Center)
      .width(60)

      Column() {
        Text(this.item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Text(`📍 ${this.item.location}`)
          .fontSize(11)
          .fontColor('#666')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 10 })
      .layoutWeight(1)

      Text(this.item.type)
        .fontSize(11)
        .fontColor('#FF6600')
        .padding({ left: 8, right: 8, top: 3, bottom: 3 })
        .backgroundColor('#FFF0E6')
        .borderRadius(4)
    }
    .width('100%')
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 6 })
  }
}
