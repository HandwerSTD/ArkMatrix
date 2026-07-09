import { Route } from '../model/DaDeMapModels'

@ComponentV2
export struct RouteCard {
  @Param route: Route = new Route()
  @Event onSelect: (route: Route) => void = (route: Route) => {}

  build() {
    Column() {
      Row() {
        Text(this.route.type)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(`${this.route.duration}`)
          .fontSize(14)
          .fontColor('#FF6600')
        Text(` | ${this.route.distance}`)
          .fontSize(14)
          .fontColor('#999')
      }
      .width('100%')

      Row() {
        Text('路况：')
          .fontSize(12)
          .fontColor('#666')
        Text(this.route.traffic)
          .fontSize(12)
          .fontColor(this.route.traffic === '拥堵' ? '#FF4444' : '#44BB44')
        if (this.route.hasDelay) {
          Text('（有延误）')
            .fontSize(12)
            .fontColor('#FF4444')
        }
      }
      .width('100%')
      .margin({ top: 6 })

      Column() {
        ForEach(this.route.steps, (step: string, index: number) => {
          Row() {
            Text(`${index + 1}.`)
              .fontSize(12)
              .fontColor('#999')
              .width(20)
            Text(step)
              .fontSize(13)
              .fontColor('#333')
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ top: 2, bottom: 2 })
        })
      }
      .width('100%')
      .margin({ top: 8 })
      .padding(8)
      .backgroundColor('#F5F5F5')
      .borderRadius(6)

      Button('选择此路线')
        .width('100%')
        .height(36)
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.onSelect(this.route)
        })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 10 })
  }
}
