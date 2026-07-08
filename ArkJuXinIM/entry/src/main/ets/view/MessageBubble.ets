import { Message } from '../model/JuXinIMModels'
import { PlanCardShare } from './PlanCardShare'

@ComponentV2
export struct MessageBubble {
  @Param message: Message = new Message()

  build() {
    Row() {
      if (this.message.isMe) {
        Blank()
      }
      Column() {
        if (this.message.isPlanCard && this.message.planCard) {
          PlanCardShare({ card: this.message.planCard })
        } else {
          Text(this.message.content)
            .fontSize(14)
            .fontColor(this.message.isMe ? Color.White : '#333')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.message.isMe ? '#FF6600' : '#F0F0F0')
            .borderRadius(12)
            .constraintSize({ maxWidth: '70%' })
        }
        Text(this.message.time)
          .fontSize(10)
          .fontColor('#BBB')
          .margin({ top: 2 })
      }
      .alignItems(this.message.isMe ? HorizontalAlign.End : HorizontalAlign.Start)
      if (!this.message.isMe) {
        Blank()
      }
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    .justifyContent(this.message.isMe ? FlexAlign.End : FlexAlign.Start)
  }
}
