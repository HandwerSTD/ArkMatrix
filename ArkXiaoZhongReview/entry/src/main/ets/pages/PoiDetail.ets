import { POI, Review } from '../model/XiaoZhongReviewModels'
import { XiaoZhongReviewMock } from '../mock/XiaoZhongReviewMock'
import { ReviewItem } from '../view/ReviewItem'
import { StarRating } from '../view/StarRating'

@Entry
@ComponentV2
export struct PoiDetail {
  @Local poi: POI | null = null
  @Local reviews: Review[] = []
  @Local isCollected: boolean = false
  @Local poiId: string = ''

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, Object>
    if (params && params['poiId']) {
      this.poiId = params['poiId'] as string
      let pois = XiaoZhongReviewMock.getAllPOIs()
      let found = pois.find(p => p.id === this.poiId)
      if (found) {
        let p = new POI()
        p.id = found.id; p.name = found.name; p.category = found.category
        p.rating = found.rating; p.reviewCount = found.reviewCount
        p.address = found.address; p.image = found.image
        p.isCollected = found.isCollected
        this.poi = p
        this.isCollected = p.isCollected
      }
    }
    this.reviews = XiaoZhongReviewMock.getReviews(this.poiId)
  }

  build() {
    Column() {
      Row() {
        Button('← 返回')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text(this.poi ? this.poi.name : '详情')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button(this.isCollected ? '★已收藏' : '☆收藏')
          .fontSize(12)
          .height(30)
          .borderRadius(15)
          .backgroundColor(this.isCollected ? '#FF6600' : '#F0F0F0')
          .margin({ right: 8 })
          .onClick(() => {
            this.isCollected = !this.isCollected
            if (this.poi) {
              this.poi.isCollected = this.isCollected
            }
          })
      }
      .width('100%')
      .padding(10)

      if (this.poi) {
        Column() {
          Text(this.poi.image)
            .fontSize(60)
            .width('100%')
            .height(160)
            .backgroundColor('#F0F0F0')
            .borderRadius(8)
            .textAlign(TextAlign.Center)
          Row() {
            StarRating({ rating: this.poi.rating })
            Text(`  ${this.poi.rating}`)
              .fontSize(16)
              .fontColor('#FF6600')
            Text(`  ${this.poi.reviewCount}条评价`)
              .fontSize(12)
              .fontColor('#999')
          }
          .margin({ top: 10 })
          Text(this.poi.address)
            .fontSize(13)
            .fontColor('#666')
            .margin({ top: 6 })
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .margin(12)
        .borderRadius(8)
      }

      Text('用户评价')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 8, bottom: 4 })

      List() {
        ForEach(this.reviews, (review: Review) => {
          ListItem() {
            ReviewItem({ review: review })
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
