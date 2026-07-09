@ComponentV2
export struct ChatInput {
  @Param disabled: boolean = false
  @Event onSend: (text: string) => void = (text: string) => {}
  @Event onSettingsClick: () => void = () => {}
  @Local inputText: string = ''

  build() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(28)
        .height(28)
        .borderRadius(14)
        .margin({ right: 8 })
        .onClick(() => {
          this.onSettingsClick()
        })

      TextInput({ placeholder: '输入消息...', text: this.inputText })
        .fontSize(14)
        .layoutWeight(1)
        .height(36)
        .backgroundColor('#F5F5F5')
        .borderRadius(18)
        .padding({ left: 14, right: 14 })
        .enabled(!this.disabled)
        .onChange((value: string) => {
          this.inputText = value
        })

      Button('发送')
        .fontSize(13)
        .height(34)
        .padding({ left: 14, right: 14 })
        .backgroundColor('#FF6600')
        .borderRadius(17)
        .margin({ left: 8 })
        .enabled(this.inputText.trim().length > 0 && !this.disabled)
        .onClick(() => {
          let text = this.inputText.trim()
          if (text.length > 0) {
            this.onSend(text)
            this.inputText = ''
          }
        })
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}
