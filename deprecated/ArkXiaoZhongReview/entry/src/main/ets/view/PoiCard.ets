import { POI } from '../model/XiaoZhongReviewModels'

@ComponentV2
export struct PoiCard {
  @Param poi: POI = new POI()
  @Event onClick: (id: string) => void = (id: string) => {}

  build() {
    Column() {
      Row() {
        Text(this.poi.image)
          .fontSize(40)
          .width(70)
          .height(70)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)
          .textAlign(TextAlign.Center)
        Column() {
          Text(this.poi.name)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
          Row() {
            Text('★')
              .fontSize(12)
              .fontColor('#FF6600')
            Text(` ${this.poi.rating}`)
              .fontSize(12)
              .fontColor('#FF6600')
            Text(`  ${this.poi.reviewCount}条评价`)
              .fontSize(11)
              .fontColor('#999')
          }
          Text(this.poi.address)
            .fontSize(11)
            .fontColor('#999')
            .maxLines(1)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
    .onClick(() => {
      this.onClick(this.poi.id)
    })
  }
}
