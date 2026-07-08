import { POI } from '../model/DaDeMapModels'
import { DaDeMapMock } from '../mock/DaDeMapMock'
import { PoiCard } from '../view/PoiCard'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local searchText: string = ''
  @Local selectedTab: number = 0
  @Local poiList: POI[] = DaDeMapMock.getNearbyPOIs()
  @Local filteredPoiList: POI[] = DaDeMapMock.getNearbyPOIs()
  private tabTitles: string[] = ['推荐', '景点', '美食', '购物']

  aboutToAppear(): void {
    this.filteredPoiList = this.poiList
  }

  build() {
    Column() {
      Row() {
        TextInput({ text: this.searchText, placeholder: '搜索地点、美食、景点...' })
          .layoutWeight(1)
          .height(40)
          .backgroundColor('#F5F5F5')
          .borderRadius(20)
          .padding({ left: 16 })
          .onChange((value: string) => {
            this.searchText = value
            this.filterPoiList()
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 8 })

      Row() {
        ForEach(['路线', '导航', '附近', '收藏'], (item: string) => {
          Column() {
            Text(item === '路线' ? '🗺' : item === '导航' ? '🧭' : item === '附近' ? '📍' : '⭐')
              .fontSize(24)
            Text(item)
              .fontSize(11)
              .fontColor('#666')
              .margin({ top: 4 })
          }
          .width('25%')
          .padding({ top: 10, bottom: 10 })
          .onClick(() => {
            if (item === '路线') {
              router.pushUrl({ url: 'pages/RouteResult' })
            } else if (item === '导航') {
              router.pushUrl({ url: 'pages/Navigation' })
            }
          })
        })
      }
      .width('100%')
      .padding({ left: 8, right: 8 })

      Row() {
        ForEach(this.tabTitles, (title: string, index: number) => {
          Text(title)
            .fontSize(14)
            .fontColor(this.selectedTab === index ? '#FF6600' : '#666')
            .padding({ left: 14, right: 14, top: 8, bottom: 8 })
            .borderRadius(16)
            .backgroundColor(this.selectedTab === index ? '#FFF0E6' : '#F5F5F5')
            .margin({ right: 8 })
            .onClick(() => {
              this.selectedTab = index
              this.filterPoiList()
            })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })

      List() {
        ForEach(this.filteredPoiList, (poi: POI) => {
          ListItem() {
            PoiCard({
              poi: poi,
              onCollect: (name: string) => {
                let found = this.poiList.find(p => p.name === name)
                if (found) {
                  found.isCollected = !found.isCollected
                }
                this.poiList = [...this.poiList]
                this.filterPoiList()
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

  private filterPoiList(): void {
    let result = this.poiList
    if (this.searchText.length > 0) {
      result = result.filter(p => p.name.indexOf(this.searchText) >= 0)
    }
    if (this.selectedTab > 0) {
      let tabType = this.tabTitles[this.selectedTab]
      if (tabType === '景点') {
        result = result.filter(p => p.type === '景点')
      } else if (tabType === '美食') {
        result = result.filter(p => p.type === '美食')
      } else if (tabType === '购物') {
        result = result.filter(p => p.type === '购物')
      }
    }
    this.filteredPoiList = result
  }
}
