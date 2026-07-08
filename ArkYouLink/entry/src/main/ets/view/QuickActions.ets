@ComponentV2
export struct QuickActions {
  @Event onLeave: () => void = () => {}
  @Event onAutoReply: () => void = () => {}
  @Event onUpdateStatus: () => void = () => {}

  build() {
    Row() {
      Column() {
        Text('🏖️')
          .fontSize(28)
        Text('请假申请')
          .fontSize(11)
          .fontColor('#666')
          .margin({ top: 2 })
      }
      .width('33%')
      .onClick(() => { this.onLeave() })
      Column() {
        Text('💬')
          .fontSize(28)
        Text('自动回复')
          .fontSize(11)
          .fontColor('#666')
          .margin({ top: 2 })
      }
      .width('33%')
      .onClick(() => { this.onAutoReply() })
      Column() {
        Text('🔄')
          .fontSize(28)
        Text('状态更新')
          .fontSize(11)
          .fontColor('#666')
          .margin({ top: 2 })
      }
      .width('34%')
      .onClick(() => { this.onUpdateStatus() })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .backgroundColor(Color.White)
    .margin({ left: 12, right: 12 })
    .borderRadius(8)
  }
}
