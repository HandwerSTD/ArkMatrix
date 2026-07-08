import { Playlist } from '../model/HuaBanMusicModels'

@ComponentV2
export struct PlaylistCard {
  @Param playlist: Playlist = new Playlist()
  @Event onExpand: (id: string) => void = (id: string) => {}

  build() {
    Column() {
      Row() {
        Text(this.playlist.cover)
          .fontSize(36)
          .width(60)
          .height(60)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)
          .textAlign(TextAlign.Center)

        Column() {
          Text(this.playlist.name)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
          Row() {
            Text(`${this.playlist.songCount}首`)
              .fontSize(12)
              .fontColor('#999')
            Text(' · ')
              .fontSize(12)
              .fontColor('#999')
            Text(this.playlist.description)
              .fontSize(12)
              .fontColor('#999')
              .maxLines(1)
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })

        Button('展开')
          .fontSize(12)
          .height(28)
          .borderRadius(14)
          .onClick(() => {
            this.onExpand(this.playlist.id)
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 10 })
  }
}
