import { UserStatus } from '../model/YouLinkModels'

@ComponentV2
export struct StatusSelector {
  @Param options: UserStatus[] = []
  @Param current: string = ''
  @Event onSelect: (status: UserStatus) => void = (status: UserStatus) => {}

  build() {
    Row() {
      ForEach(this.options, (opt: UserStatus) => {
        Row() {
          Text(opt.icon)
            .fontSize(14)
          Text(opt.label)
            .fontSize(12)
            .fontColor(this.current === opt.label ? '#FF6600' : '#666')
            .margin({ left: 4 })
        }
        .padding({ left: 10, right: 10, top: 6, bottom: 6 })
        .backgroundColor(this.current === opt.label ? '#FFF0E6' : '#F5F5F5')
        .borderRadius(14)
        .margin({ right: 8 })
        .onClick(() => {
          this.onSelect(opt)
        })
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }
}
