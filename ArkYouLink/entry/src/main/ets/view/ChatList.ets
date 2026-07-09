import { Message } from '../protocol/Message'
import { ChatBubble } from './ChatBubble'

@ComponentV2
export struct ChatList {
  @Param messages: Message[] = []
  private scroller: Scroller = new Scroller()

  build() {
    List({ scroller: this.scroller }) {
      ForEach(this.messages, (msg: Message) => {
        ListItem() {
          ChatBubble({ message: msg })
        }
      }, (msg: Message) => msg.id)
    }
    .layoutWeight(1)
    .width('100%')
    .backgroundColor('#F8F8F8')
  }

  @Monitor('messages.length')
  onMessagesChanged() {
    let count = this.messages.length
    if (count > 0) {
      this.scroller.scrollToIndex(count - 1, false)
    }
  }
}
