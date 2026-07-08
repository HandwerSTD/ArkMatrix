import { Trip } from '../model/TripModels'
import { TripManagerMock } from '../mock/TripManagerMock'
import { TripCard } from '../view/TripCard'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local trips: Trip[] = TripManagerMock.getTrips()
  @Local showNewForm: boolean = false
  @Local newTripTitle: string = ''
  @Local newTripDest: string = ''
  @Local newTripStart: string = ''
  @Local newTripEnd: string = ''

  build() {
    Column() {
      Text('方舟旅迹')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 4 })

      if (this.showNewForm) {
        Column() {
          Text('新建旅行')
            .fontSize(15).fontWeight(FontWeight.Bold).width('100%').margin({ bottom: 8 })
          TextInput({ text: this.newTripTitle, placeholder: '旅行标题' })
            .width('100%').height(38).backgroundColor('#F5F5F5').borderRadius(6)
            .padding({ left: 10 }).margin({ bottom: 6 })
            .onChange((v: string) => { this.newTripTitle = v })
          TextInput({ text: this.newTripDest, placeholder: '目的地' })
            .width('100%').height(38).backgroundColor('#F5F5F5').borderRadius(6)
            .padding({ left: 10 }).margin({ bottom: 6 })
            .onChange((v: string) => { this.newTripDest = v })
          TextInput({ text: this.newTripStart, placeholder: '开始日期 (如: 2025-07-14)' })
            .width('100%').height(38).backgroundColor('#F5F5F5').borderRadius(6)
            .padding({ left: 10 }).margin({ bottom: 6 })
            .onChange((v: string) => { this.newTripStart = v })
          TextInput({ text: this.newTripEnd, placeholder: '结束日期 (如: 2025-07-16)' })
            .width('100%').height(38).backgroundColor('#F5F5F5').borderRadius(6)
            .padding({ left: 10 }).margin({ bottom: 10 })
            .onChange((v: string) => { this.newTripEnd = v })
          Row() {
            Button('取消')
              .fontSize(13).height(34).layoutWeight(1)
              .backgroundColor('#F0F0F0').borderRadius(17)
              .onClick(() => { this.showNewForm = false })
            Button('创建')
              .fontSize(13).height(34).layoutWeight(1).margin({ left: 10 })
              .backgroundColor('#FF6600').fontColor(Color.White).borderRadius(17)
              .onClick(() => {
                if (this.newTripTitle.length > 0 && this.newTripDest.length > 0) {
                  let t = TripManagerMock.createTrip({
                    title: this.newTripTitle,
                    destination: this.newTripDest,
                    startDate: this.newTripStart,
                    endDate: this.newTripEnd
                  })
                  this.trips = [t].concat(this.trips)
                  this.showNewForm = false
                  promptAction.showToast({ message: '旅行创建成功' })
                }
              })
          }.width('100%')
        }
        .width('100%')
        .padding(14)
        .backgroundColor(Color.White)
        .margin({ left: 12, right: 12 })
        .borderRadius(10)
      }

      List() {
        ForEach(this.trips, (trip: Trip) => {
          ListItem() {
            TripCard({
              trip: trip,
              onClick: (id: string) => {
                router.pushUrl({ url: 'pages/TripDetail', params: { tripId: id } as Record<string, Object> })
              }
            })
          }
        })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 8 })

      Button('+ 新建旅行')
        .fontSize(15)
        .width('90%')
        .height(44)
        .borderRadius(22)
        .backgroundColor('#FF6600')
        .fontColor(Color.White)
        .margin({ bottom: 16 })
        .onClick(() => { this.showNewForm = !this.showNewForm })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
