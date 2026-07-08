import { LeaveRecord } from '../model/YouLinkModels'
import { YouLinkMock } from '../mock/YouLinkMock'
import { LeaveRecordCard } from '../view/LeaveRecordCard'
import { LeaveForm } from '../view/LeaveForm'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct LeaveStatus {
  @Local records: LeaveRecord[] = YouLinkMock.getLeaveRecords()
  @Local showForm: boolean = false

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text('请假管理')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button('+ 新建')
          .fontSize(13)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#FF6600')
          .fontColor(Color.White)
          .onClick(() => {
            this.showForm = !this.showForm
          })
          .margin({ right: 4 })
      }
      .width('100%')
      .padding(10)

      if (this.showForm) {
        LeaveForm({
          onSubmit: (type: string, reason: string) => {
            let newRecord = YouLinkMock.submitLeave(type, reason)
            this.records = [newRecord].concat(this.records)
            this.showForm = false
            promptAction.showToast({ message: '请假申请已提交' })
          }
        })
      }

      Text('请假记录')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 8, bottom: 4 })

      List() {
        ForEach(this.records, (record: LeaveRecord) => {
          ListItem() {
            LeaveRecordCard({ record: record })
          }
        })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
