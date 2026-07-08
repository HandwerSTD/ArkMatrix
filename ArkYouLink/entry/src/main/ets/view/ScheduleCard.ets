import { ScheduleEvent } from '../model/YouLinkModels'

@ComponentV2
export struct ScheduleCard {
  @Param event: ScheduleEvent = new ScheduleEvent()

  build() {
    Row() {
      Text(this.event.isImportant ? '🔴' : '⚪')
        .fontSize(10)
        .margin({ right: 8 })
      Column() {
        Text(this.event.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Row() {
          Text(this.event.time)
            .fontSize(11)
            .fontColor('#999')
          if (this.event.location.length > 0) {
            Text(`  📍 ${this.event.location}`)
              .fontSize(11)
              .fontColor('#999')
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
  }
}
