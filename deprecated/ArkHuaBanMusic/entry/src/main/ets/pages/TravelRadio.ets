import { TravelRadio } from '../model/HuaBanMusicModels'
import { HuaBanMusicMock } from '../mock/HuaBanMusicMock'
import { RadioCard } from '../view/RadioCard'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct TravelRadioPage {
  @Local destination: string = ''
  @Local radio: TravelRadio = new TravelRadio()

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => {
            router.back()
          })
        Text('AI 旅行电台')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(12)

      Column() {
        Text('输入你的旅行目的地')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .margin({ bottom: 10 })

        Row() {
          TextInput({ text: this.destination, placeholder: '例如：南京、北京、成都...' })
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .onChange((value: string) => {
              this.destination = value
            })
          Button('生成')
            .fontSize(14)
            .height(44)
            .width(70)
            .margin({ left: 10 })
            .borderRadius(22)
            .backgroundColor('#FF6699')
            .onClick(() => {
              if (this.destination.length > 0) {
                this.radio = HuaBanMusicMock.generateRadio(this.destination)
              }
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 12 })
      .borderRadius(8)

      Column() {
        RadioCard({ radio: this.radio })
      }
      .width('100%')
      .padding({ left: 12, right: 12 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
