import { DaDeMapMock } from '../mock/DaDeMapMock'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Navigation {
  @Local currentStep: number = 0
  @Local steps: string[] = DaDeMapMock.getNavigationSteps()

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => {
            router.back()
          })
        Text('实时导航')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(12)

      Column() {
        Text('当前位置 → 南京南站')
          .fontSize(14)
          .fontColor('#666')
        Text('预计到达：14:35')
          .fontSize(14)
          .fontColor('#FF6600')
        Text('前方1.2km缓行路段')
          .fontSize(12)
          .fontColor('#FF4444')
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin(12)
      .borderRadius(8)

      Column() {
        Text('导航步骤')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })

        List() {
          ForEach(this.steps, (step: string, index: number) => {
            ListItem() {
              Row() {
                Text(`${index + 1}`)
                  .fontSize(14)
                  .fontColor(index === this.currentStep ? '#FF6600' : '#999')
                  .width(28)
                  .height(28)
                  .borderRadius(14)
                  .backgroundColor(index === this.currentStep ? '#FFF0E6' : '#F5F5F5')
                  .textAlign(TextAlign.Center)
                Text(step)
                  .fontSize(13)
                  .fontColor(index === this.currentStep ? '#333' : '#999')
                  .layoutWeight(1)
                  .margin({ left: 10 })
              }
              .width('100%')
              .padding({ top: 6, bottom: 6 })
              .backgroundColor(index === this.currentStep ? '#FFF8F2' : Color.White)
              .borderRadius(6)
              .margin({ bottom: 4 })
            }
          })
        }
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      Row() {
        Button('上一步')
          .fontSize(14)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep--
            }
          })
        Button('下一步')
          .fontSize(14)
          .layoutWeight(1)
          .margin({ left: 10 })
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep++
            }
          })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
