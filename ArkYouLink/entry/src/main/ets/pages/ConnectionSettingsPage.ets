import { preferences } from '@kit.ArkData'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct ConnectionSettingsPage {
  @Local url: string = 'ws://localhost:18789'
  @Local savedUrl: string = ''

  aboutToAppear(): void {
    let prefs = preferences.getPreferencesSync(getContext(), { name: 'chat_settings' })
    this.savedUrl = prefs.getSync('connection_url', 'ws://localhost:18789') as string
    this.url = this.savedUrl
  }

  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .margin({ right: 8 })
          .onClick(() => {
            router.back()
          })
        Text('连接设置')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)

      Column() {
        Text('WebSocket 地址')
          .fontSize(12)
          .fontColor('#999')
          .width('100%')
          .margin({ bottom: 8 })

        TextInput({ placeholder: 'ws://host:port', text: this.url })
          .fontSize(14)
          .width('100%')
          .height(44)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .padding({ left: 12, right: 12 })
          .onChange((value: string) => {
            this.url = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ left: 12, right: 12, top: 12 })

      Button('保存连接')
        .fontSize(14)
        .width('100%')
        .height(44)
        .backgroundColor('#FF6600')
        .borderRadius(22)
        .margin({ left: 12, right: 12, top: 24 })
        .onClick(() => {
          let prefs = preferences.getPreferencesSync(getContext(), { name: 'chat_settings' })
          prefs.putSync('connection_url', this.url.trim())
          prefs.flush()
          this.savedUrl = this.url.trim()
          promptAction.showToast({ message: '已保存，请返回聊天页重新连接' })
        })

      if (this.savedUrl.length > 0) {
        Text(`当前地址：${this.savedUrl}`)
          .fontSize(12)
          .fontColor('#999')
          .margin({ top: 12 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
