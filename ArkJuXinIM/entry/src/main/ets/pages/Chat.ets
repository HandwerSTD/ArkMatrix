import { Message, PlanCardData } from '../model/JuXinIMModels'
import { JuXinIMMock } from '../mock/JuXinIMMock'
import { MessageBubble } from '../view/MessageBubble'
import { ShareMenu } from '../view/ShareMenu'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Chat {
  @Local messages: Message[] = []
  @Local inputText: string = ''
  @Local contactName: string = ''
  @Local contactId: string = ''

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, string>
    if (params) {
      this.contactId = params['contactId'] || ''
      this.contactName = params['contactName'] || ''
    }
    this.messages = JuXinIMMock.getMessages(this.contactId)
  }

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text(this.contactName)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('...')
          .fontSize(20)
          .padding({ right: 10 })
      }
      .width('100%')
      .padding({ top: 8, bottom: 4 })

      List() {
        ForEach(this.messages, (msg: Message) => {
          ListItem() {
            MessageBubble({ message: msg })
          }
        })
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')

      ShareMenu({
        onSharePlan: () => {
          let newMsg = new Message()
          newMsg.id = 'm_new_' + Date.now()
          newMsg.content = ''
          newMsg.time = new Date().getHours() + ':' + String(new Date().getMinutes()).padStart(2, '0')
          newMsg.isMe = true
          newMsg.isPlanCard = true
          let card = new PlanCardData()
          card.title = '南京三日游'
          card.date = '2025年7月14日-16日'
          card.destination = '南京'
          card.ticketInfo = 'G123 北京南→南京南 12:00出发'
          card.poiCount = 8
          newMsg.planCard = card
          this.messages = this.messages.concat([newMsg])
        }
      })

      Row() {
        TextInput({ text: this.inputText, placeholder: '输入消息...' })
          .layoutWeight(1)
          .height(40)
          .backgroundColor('#F5F5F5')
          .borderRadius(20)
          .padding({ left: 14 })
          .onChange((v) => { this.inputText = v })
        Button('发送')
          .fontSize(13)
          .height(40)
          .width(60)
          .margin({ left: 8 })
          .borderRadius(20)
          .backgroundColor('#FF6600')
          .fontColor(Color.White)
          .onClick(() => {
            if (this.inputText.length > 0) {
              let newMsg = new Message()
              newMsg.id = 'm_t_' + Date.now()
              newMsg.content = this.inputText
              newMsg.time = new Date().getHours() + ':' + String(new Date().getMinutes()).padStart(2, '0')
              newMsg.isMe = true
              this.messages = this.messages.concat([newMsg])
              this.inputText = ''
            }
          })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
