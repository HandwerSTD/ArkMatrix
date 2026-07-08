import { LeaveRecord } from '../model/YouLinkModels'

@ComponentV2
export struct LeaveRecordCard {
  @Param record: LeaveRecord = new LeaveRecord()

  build() {
    Column() {
      Row() {
        Text(this.record.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(this.record.status)
          .fontSize(12)
          .fontColor(this.record.status === '已审批' ? '#44BB44' : '#FFAA00')
      }
      .width('100%')
      Text(`${this.record.startDate} ~ ${this.record.endDate}`)
        .fontSize(12)
        .fontColor('#666')
        .width('100%')
        .margin({ top: 4 })
      Text(`事由: ${this.record.reason}`)
        .fontSize(12)
        .fontColor('#999')
        .width('100%')
        .margin({ top: 2 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
  }
}
