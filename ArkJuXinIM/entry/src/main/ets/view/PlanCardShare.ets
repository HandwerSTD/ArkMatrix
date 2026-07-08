import { PlanCardData } from '../model/JuXinIMModels'

@ComponentV2
export struct PlanCardShare {
  @Param card: PlanCardData = new PlanCardData()

  build() {
    Column() {
      Text('📋 旅行计划卡片')
        .fontSize(12)
        .fontColor('#FF6600')
        .width('100%')
        .margin({ bottom: 6 })
      Text(this.card.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
      Text(`📅 ${this.card.date}`)
        .fontSize(12)
        .fontColor('#666')
        .width('100%')
        .margin({ top: 4 })
      Text(`📍 ${this.card.destination}`)
        .fontSize(12)
        .fontColor('#666')
        .width('100%')
      Text(`🚄 ${this.card.ticketInfo}`)
        .fontSize(12)
        .fontColor('#666')
        .width('100%')
      Text(`📌 ${this.card.poiCount}个打卡点`)
        .fontSize(12)
        .fontColor('#666')
        .width('100%')
      Row() {
        Text('点击查看完整行程')
          .fontSize(12)
          .fontColor('#FF6600')
      }
      .width('100%')
      .margin({ top: 8 })
      .padding({ top: 8 })
      .border({ width: { top: 0.5 }, color: '#EEE' })
    }
    .width(240)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .border({ width: 1, color: '#FFE0CC' })
    .shadow({ radius: 4, color: '#10000000', offsetY: 2 })
  }
}
