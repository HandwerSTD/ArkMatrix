import { Trip, DailyPlan, PlanItem } from '../model/TripModels'
import { TripManagerMock } from '../mock/TripManagerMock'
import { DayTabBar } from '../view/DayTabBar'
import { PlanItemCard } from '../view/PlanItemCard'
import { AddPlanForm } from '../view/AddPlanForm'

@Entry
@ComponentV2
export struct TripDetail {
  @Local trip: Trip | null = null
  @Local selectedDay: number = 1
  @Local dayItems: PlanItem[] = []
  @Local showAddForm: boolean = false
  @Local tripId: string = ''

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, string>
    if (params && params['tripId']) {
      this.tripId = params['tripId'] as string
      let trips = TripManagerMock.getTrips()
      let found = trips.find((t: Trip) => t.id === this.tripId)
      if (found) {
        this.trip = found
        this.loadDayItems()
      }
    }
  }

  private loadDayItems(): void {
    if (this.trip) {
      let dp = this.trip.dailyPlans.find((d: DailyPlan) => d.day === this.selectedDay)
      this.dayItems = dp ? dp.items : []
    }
  }

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text(this.trip ? this.trip.title : '行程详情')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(10)

      if (this.trip) {
        Column() {
          Text(this.trip.cover)
            .fontSize(48)
            .width('100%')
            .height(100)
            .backgroundColor('#F0F0F0')
            .borderRadius(8)
            .textAlign(TextAlign.Center)
          Row() {
            Text(`${this.trip.startDate} ~ ${this.trip.endDate}`)
              .fontSize(13).fontColor('#999')
            Blank()
            Text(this.trip.status)
              .fontSize(13)
              .fontColor('#FF6600')
          }.width('100%').margin({ top: 8 })
        }
        .width('100%')
        .padding(14)
        .backgroundColor(Color.White)
        .margin({ left: 12, right: 12, top: 8 })
        .borderRadius(10)

        DayTabBar({
          days: this.trip.dailyPlans.map((dp: DailyPlan) => dp.day),
          selected: this.selectedDay,
          onSelect: (day: number) => {
            this.selectedDay = day
            this.loadDayItems()
          }
        })

        List() {
          ForEach(this.dayItems, (item: PlanItem, index: number) => {
            ListItem() {
              PlanItemCard({ item: item })
            }
          })
        }
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })

        if (this.showAddForm) {
          AddPlanForm({
            onSubmit: (item: PlanItem) => {
              if (this.trip) {
                let dp = this.trip.dailyPlans.find((d: DailyPlan) => d.day === this.selectedDay)
                if (dp) {
                  dp.items = dp.items.concat([item])
                }
                this.trip = { ...this.trip } as Trip
                this.loadDayItems()
              }
              this.showAddForm = false
            }
          })
          .padding({ left: 12, right: 12, bottom: 8 })
        }

        Button('+ 添加行程项')
          .fontSize(14)
          .width('90%')
          .height(40)
          .borderRadius(20)
          .backgroundColor('#FF6600')
          .fontColor(Color.White)
          .margin({ bottom: 12 })
          .onClick(() => { this.showAddForm = !this.showAddForm })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
