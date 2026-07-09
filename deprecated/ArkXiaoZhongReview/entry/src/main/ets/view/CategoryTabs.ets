@ComponentV2
export struct CategoryTabs {
  @Param tabs: string[] = []
  @Param selected: number = 0
  @Event onSelect: (index: number) => void = (index: number) => {}

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Text(tab)
          .fontSize(13)
          .fontColor(this.selected === index ? '#FF6600' : '#666')
          .padding({ left: 12, right: 12, top: 7, bottom: 7 })
          .borderRadius(14)
          .backgroundColor(this.selected === index ? '#FFF0E6' : '#F0F0F0')
          .margin({ right: 8 })
          .onClick(() => {
            this.onSelect(index)
          })
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 6, bottom: 6 })
    .scrollable(ScrollDirection.Horizontal)
  }
}
