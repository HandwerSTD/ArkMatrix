import { POI } from '../model/DaDeMapModels'

@ComponentV2
export struct PoiCard {
  @Param poi: POI = new POI()
  @Event onCollect: (name: string) => void = (name: string) => {}

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.poi.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
          Row() {
            Text(this.poi.type)
              .fontSize(12)
              .fontColor('#666')
            Text(` ★ ${this.poi.rating}`)
              .fontSize(12)
              .fontColor('#FF6600')
            Text(` ${this.poi.distance}`)
              .fontSize(12)
              .fontColor('#999')
          }
          .width('100%')
          Text(this.poi.address)
            .fontSize(12)
            .fontColor('#999')
            .maxLines(1)
          Row() {
            ForEach(this.poi.tags, (tag: string) => {
              Text(tag)
                .fontSize(10)
                .fontColor('#FF6600')
                .backgroundColor('#FFF0E6')
                .borderRadius(4)
                .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                .margin({ right: 4 })
            })
          }
          .width('100%')
          .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Button(this.poi.isCollected ? '已收藏' : '收藏')
          .fontSize(12)
          .backgroundColor(this.poi.isCollected ? '#DDD' : '#FF6600')
          .borderRadius(16)
          .height(32)
          .onClick(() => {
            this.onCollect(this.poi.name)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 10 })
  }
}
