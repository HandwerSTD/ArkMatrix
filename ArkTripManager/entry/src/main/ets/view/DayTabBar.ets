@ComponentV2
export struct DayTabBar {
  @Param days: number[] = []
  @Param selected: number = 0
  @Event onSelect: (day: number) => void = (day: number) => {}

  build() {
    Row() {
      ForEach(this.days, (day: number) => {
        Text(`第${day}天`)
          .fontSize(13)
          .fontColor(this.selected === day ? '#FF6600' : '#666')
          .padding({ left: 14, right: 14, top: 7, bottom: 7 })
          .borderRadius(16)
          .backgroundColor(this.selected === day ? '#FFF0E6' : '#F0F0F0')
          .margin({ right: 8 })
          .onClick(() => {
            this.onSelect(day)
          })
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 6, bottom: 6 })
    .scrollable(ScrollDirection.Horizontal)
  }
}
