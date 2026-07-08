import { Ticket } from '../model/HangLvTravelModels'
import { HangLvTravelMock } from '../mock/HangLvTravelMock'
import { TicketCard } from '../view/TicketCard'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct SearchResult {
  @Local tickets: Ticket[] = []

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, string>
    let from = params ? (params['from'] || '北京') : '北京'
    let to = params ? (params['to'] || '南京') : '南京'
    let date = params ? (params['date'] || '2025-07-14') : '2025-07-14'
    this.tickets = HangLvTravelMock.searchTickets(from, to, date)
  }

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text('搜索结果')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(10)

      List() {
        ForEach(this.tickets, (ticket: Ticket) => {
          ListItem() {
            TicketCard({
              ticket: ticket,
              onBook: (id: string) => {
                HangLvTravelMock.bookTicket(id)
                let found = this.tickets.find(t => t.id === id)
                if (found) {
                  found.isBooked = true
                }
                this.tickets = [...this.tickets]
                promptAction.showToast({ message: '预订成功' })
              },
              onSubscribe: (id: string, value: boolean) => {
                let found = this.tickets.find(t => t.id === id)
                if (found) {
                  found.isSubscribed = value
                }
                this.tickets = [...this.tickets]
                promptAction.showToast({ message: value ? '已订阅延误提醒' : '已取消订阅' })
              }
            })
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
