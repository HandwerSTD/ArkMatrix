import { Message, MessageStatus } from '../protocol/Message'

@ComponentV2
export struct ChatBubble {
  @Param message: Message = new Message()

  build() {
    Row() {
      if (this.message.isAssistant || this.message.isSystem) {
        this.buildAvatar()
        this.buildContent()
        Blank()
      } else {
        Blank()
        this.buildContent()
        this.buildAvatar()
      }
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    .justifyContent(this.message.isUser ? FlexAlign.End : FlexAlign.Start)
  }

  @Builder
  buildAvatar() {
    Text(this.message.isUser ? '👤' : (this.message.isSystem ? '⚙️' : '🦞'))
      .fontSize(28)
      .margin(this.message.isUser ? { left: 8 } : { right: 8 })
  }

  @Builder
  buildContent() {
    Column() {
      if (this.message.isText) {
        Text(this.message.text)
          .fontSize(14)
          .fontColor(this.message.isUser ? Color.White : '#333')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.message.isUser ? '#FF6600' : (this.message.isSystem ? '#F0F0F0' : '#FFFFFF'))
          .borderRadius(12)
          .constraintSize({ maxWidth: '75%' })
      } else if (this.message.isImage) {
        Column() {
          if (this.message.text.length > 0) {
            Text(this.message.text)
              .fontSize(12)
              .fontColor('#999')
              .margin({ bottom: 6 })
          }
          Image(this.message.imageUrl)
            .width(200)
            .height(150)
            .borderRadius(8)
            .objectFit(ImageFit.Cover)
            .backgroundColor('#F0F0F0')
        }
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor(this.message.isUser ? '#FF6600' : '#FFFFFF')
        .borderRadius(12)
        .constraintSize({ maxWidth: '75%' })
      }

      if (this.message.isUser && this.message.status === MessageStatus.Error) {
        Text('发送失败')
          .fontSize(10)
          .fontColor('#FF3B30')
          .margin({ top: 2 })
      }
    }
    .alignItems(this.message.isUser ? HorizontalAlign.End : HorizontalAlign.Start)
  }
}
