import { Review } from '../model/XiaoZhongReviewModels'
import { StarRating } from './StarRating'

@ComponentV2
export struct ReviewItem {
  @Param review: Review = new Review()

  build() {
    Column() {
      Row() {
        Text(this.review.author)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(this.review.date)
          .fontSize(11)
          .fontColor('#999')
      }
      .width('100%')
      StarRating({ rating: this.review.rating })
      Text(this.review.content)
        .fontSize(13)
        .fontColor('#666')
        .width('100%')
        .margin({ top: 6 })
        .maxLines(3)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
  }
}
