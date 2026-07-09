import { TravelRadio } from '../model/HuaBanMusicModels'

@ComponentV2
export struct RadioCard {
  @Param radio: TravelRadio = new TravelRadio()

  build() {
    Column() {
      if (!this.radio.isGenerated) {
        Text('输入目的地生成专属旅行电台')
          .fontSize(14)
          .fontColor('#999')
          .width('100%')
          .textAlign(TextAlign.Center)
      } else {
        Row() {
          Text('🎵')
            .fontSize(28)
          Column() {
            Text(this.radio.destination)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Text(`心情：${this.radio.mood}`)
              .fontSize(12)
              .fontColor('#FF6699')
              .margin({ top: 2 })
          }
          .margin({ left: 10 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .margin({ bottom: 10 })

        Text(this.radio.description)
          .fontSize(12)
          .fontColor('#666')
          .width('100%')
          .margin({ bottom: 8 })

        Column() {
          ForEach(this.radio.songs, (song: string, index: number) => {
            Row() {
              Text(`${index + 1}`)
                .fontSize(12)
                .fontColor('#999')
                .width(24)
              Text(song)
                .fontSize(13)
                .fontColor('#333')
                .layoutWeight(1)
              Text('▶')
                .fontSize(14)
                .fontColor('#FF6699')
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })
            .border({
              width: { bottom: index < this.radio.songs.length - 1 ? 0.5 : 0 },
              color: '#EEE'
            })
          })
        }
        .width('100%')
        .padding(8)
        .backgroundColor('#FAFAFA')
        .borderRadius(6)
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ top: 12 })
  }
}
