import { Playlist } from '../model/HuaBanMusicModels'
import { HuaBanMusicMock } from '../mock/HuaBanMusicMock'
import { PlaylistCard } from '../view/PlaylistCard'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local playlists: Playlist[] = HuaBanMusicMock.getPlaylists()
  @Local expandedId: string = ''

  build() {
    Column() {
      Text('花瓣音乐')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 4 })

      Column() {
        Row() {
          Text('🎧')
            .fontSize(32)
          Column() {
            Text('AI 旅行电台')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text('为你的旅程生成专属音乐')
              .fontSize(12)
              .fontColor('#FF6699')
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
          .layoutWeight(1)
          Button('立即体验')
            .fontSize(12)
            .height(30)
            .borderRadius(15)
            .backgroundColor('#FF6699')
            .onClick(() => {
              router.pushUrl({ url: 'pages/TravelRadio' })
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(14)
      .margin({ left: 16, right: 16, top: 12, bottom: 8 })
      .backgroundColor('#FFF0F5')
      .borderRadius(12)

      Text('推荐歌单')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 10, bottom: 6 })

      List() {
        ForEach(this.playlists, (playlist: Playlist) => {
          ListItem() {
            PlaylistCard({
              playlist: playlist,
              onExpand: (id: string) => {
                this.expandedId = this.expandedId === id ? '' : id
              }
            })
          }
          ListItem() {
            if (this.expandedId !== '') {
              let pl = this.playlists.find(p => p.id === this.expandedId)
              if (pl) {
                Column() {
                  ForEach(pl.songs, (song: string) => {
                    Row() {
                      Text('♪')
                        .fontSize(12)
                        .fontColor('#FF6699')
                        .width(20)
                      Text(song)
                        .fontSize(13)
                        .fontColor('#333')
                        .layoutWeight(1)
                    }
                    .width('100%')
                    .padding({ top: 4, bottom: 4 })
                  })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#FAFAFA')
                .borderRadius(6)
                .margin({ left: 16, right: 16, bottom: 8 })
              }
            }
          }
        })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
