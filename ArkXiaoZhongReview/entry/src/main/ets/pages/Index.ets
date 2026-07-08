import { POI } from '../model/XiaoZhongReviewModels'
import { XiaoZhongReviewMock } from '../mock/XiaoZhongReviewMock'
import { PoiCard } from '../view/PoiCard'
import { CategoryTabs } from '../view/CategoryTabs'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local searchQuery: string = ''
  @Local categoryTab: number = 0
  @Local poiList: POI[] = XiaoZhongReviewMock.getAllPOIs()
  @Local filteredPoiList: POI[] = XiaoZhongReviewMock.getAllPOIs()
  private tabs: string[] = ['全部', '景点', '美食', '购物']

  aboutToAppear(): void {
    this.filterPoiList()
  }

  build() {
    Column() {
      Text('小众点评')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 4 })

      Row() {
        TextInput({ text: this.searchQuery, placeholder: '搜索美食、景点、购物...' })
          .layoutWeight(1)
          .height(40)
          .backgroundColor('#F5F5F5')
          .borderRadius(20)
          .padding({ left: 16 })
          .onChange((value: string) => {
            this.searchQuery = value
            this.filterPoiList()
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      CategoryTabs({
        tabs: this.tabs,
        selected: this.categoryTab,
        onSelect: (index: number) => {
          this.categoryTab = index
          this.filterPoiList()
        }
      })

      List() {
        ForEach(this.filteredPoiList, (poi: POI) => {
          ListItem() {
            PoiCard({
              poi: poi,
              onClick: (id: string) => {
                router.pushUrl({ url: 'pages/PoiDetail', params: { poiId: id } })
              }
            })
          }
        })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      Button('+')
        .fontSize(28)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#FF6600')
        .fontColor(Color.White)
        .position({ right: 20, bottom: 20 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/PostReview' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  private filterPoiList(): void {
    let tab = this.tabs[this.categoryTab]
    this.filteredPoiList = XiaoZhongReviewMock.searchPOI(this.searchQuery, tab)
  }
}
