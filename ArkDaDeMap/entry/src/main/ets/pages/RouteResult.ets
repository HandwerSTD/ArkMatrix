import { Route } from '../model/DaDeMapModels'
import { DaDeMapMock } from '../mock/DaDeMapMock'
import { RouteCard } from '../view/RouteCard'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct RouteResult {
  @Local routes: Route[] = DaDeMapMock.getRoutes()

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => {
            router.back()
          })
        Text('路线规划')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(12)

      List() {
        ForEach(this.routes, (route: Route) => {
          ListItem() {
            RouteCard({
              route: route,
              onSelect: (r: Route) => {
                promptAction.showToast({ message: `已选择${r.type}路线` })
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
