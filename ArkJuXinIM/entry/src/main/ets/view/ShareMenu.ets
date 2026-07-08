@ComponentV2
export struct ShareMenu {
  @Event onSharePlan: () => void = () => {}

  build() {
    Row() {
      Button('📍 分享位置')
        .fontSize(12)
        .height(34)
        .layoutWeight(1)
        .borderRadius(6)
        .backgroundColor('#F0F0F0')
        .margin({ right: 6 })
      Button('📋 分享旅行计划')
        .fontSize(12)
        .height(34)
        .layoutWeight(1)
        .borderRadius(6)
        .backgroundColor('#FFF0E6')
        .onClick(() => {
          this.onSharePlan()
        })
        .margin({ right: 6 })
      Button('📷 拍照')
        .fontSize(12)
        .height(34)
        .layoutWeight(1)
        .borderRadius(6)
        .backgroundColor('#F0F0F0')
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(Color.White)
  }
}
