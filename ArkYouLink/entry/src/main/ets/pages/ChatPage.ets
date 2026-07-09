import { ChatList } from '../view/ChatList'
import { ChatInput } from '../view/ChatInput'
import { ChatViewModel } from '../viewmodel/ChatViewModel'
import { ConnectionState } from '../protocol/IMessageConnector'
import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct ChatPage {
  @Local viewModel: ChatViewModel = new ChatViewModel()

  aboutToAppear(): void {
    this.viewModel.init().then(() => {
      this.viewModel.connect()
    })
  }

  aboutToDisappear(): void {
    this.viewModel.disconnect()
  }

  build() {
    Column() {
      Row() {
        Text('🦞 OpenClaw Bot')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Text(this.statusText())
          .fontSize(11)
          .fontColor(this.connectionIsOk() ? '#34C759' : '#999')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      .border({ width: { bottom: 0.5 }, color: '#E5E5E5' })

      if (this.viewModel.messages.length === 0 && this.connectionIsOk()) {
        Column() {
          Text('🦞')
            .fontSize(48)
            .margin({ bottom: 12 })
          Text('开始和 Bot 对话吧')
            .fontSize(14)
            .fontColor('#999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else {
        ChatList({ messages: this.viewModel.messages })
      }

      ChatInput({
        disabled: !this.connectionIsOk(),
        onSend: (text: string) => {
          this.viewModel.sendText(text)
        },
        onSettingsClick: () => {
          router.pushUrl({ url: 'pages/ConnectionSettingsPage' })
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  private connectionIsOk(): boolean {
    return this.viewModel.connectionState === ConnectionState.Connected
  }

  private statusText(): string {
    switch (this.viewModel.connectionState) {
      case ConnectionState.Connected:
        return '已连接'
      case ConnectionState.Connecting:
        return '连接中…'
      case ConnectionState.Disconnected:
        return '已断开'
      default:
        return '未连接'
    }
  }
}
