import { Trip } from '../model/HangLvTravelModels'
import { HangLvTravelMock } from '../mock/HangLvTravelMock'
import { TripCard } from '../view/TripCard'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct MyTrips {
  @Local trips: Trip[] = HangLvTravelMock.getMyTrips()

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text('我的行程')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(10)

      List() {
        ForEach(this.trips, (trip: Trip) => {
          ListItem() {
            TripCard({
              trip: trip,
              onCancel: (id: string) => {
                let found = this.trips.find(t => t.id === id)
                if (found) {
                  found.status = '已取消'
                }
                this.trips = [...this.trips]
                promptAction.showToast({ message: '已取消订单' })
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
