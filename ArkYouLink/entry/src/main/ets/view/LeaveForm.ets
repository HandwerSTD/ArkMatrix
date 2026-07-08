@ComponentV2
export struct LeaveForm {
  @Local selectedType: string = '年假'
  @Local reason: string = ''
  private types: string[] = ['年假', '事假', '病假']
  @Event onSubmit: (type: string, reason: string) => void = (type: string, reason: string) => {}

  build() {
    Column() {
      Text('请假类型')
        .fontSize(13)
        .fontColor('#666')
        .width('100%')
        .margin({ bottom: 6 })
      Row() {
        ForEach(this.types, (t: string) => {
          Text(t)
            .fontSize(13)
            .fontColor(this.selectedType === t ? '#FF6600' : '#666')
            .padding({ left: 14, right: 14, top: 6, bottom: 6 })
            .backgroundColor(this.selectedType === t ? '#FFF0E6' : '#F0F0F0')
            .borderRadius(14)
            .margin({ right: 8 })
            .onClick(() => { this.selectedType = t })
        })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Text('请假事由')
        .fontSize(13)
        .fontColor('#666')
        .width('100%')
        .margin({ bottom: 6 })
      TextArea({ text: this.reason, placeholder: '请输入请假事由...' })
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .borderRadius(6)
        .padding(10)
        .onChange((v) => { this.reason = v })

      Button('提交申请')
        .width('100%')
        .height(40)
        .fontSize(14)
        .margin({ top: 12 })
        .borderRadius(20)
        .backgroundColor('#FF6600')
        .fontColor(Color.White)
        .onClick(() => {
          if (this.reason.length > 0) {
            this.onSubmit(this.selectedType, this.reason)
          }
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}
