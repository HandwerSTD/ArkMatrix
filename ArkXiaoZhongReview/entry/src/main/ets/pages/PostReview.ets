import { promptAction } from '@kit.ArkUI'
import { StarRating } from '../view/StarRating'

@Entry
@ComponentV2
export struct PostReview {
  @Local inputRating: number = 0
  @Local inputContent: string = ''
  @Local inputAuthor: string = ''

  build() {
    Column() {
      Row() {
        Button('← 取消')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text('发布评价')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button('发布')
          .fontSize(14)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#FF6600')
          .fontColor(Color.White)
          .onClick(() => {
            if (this.inputContent.length > 0 && this.inputRating > 0) {
              promptAction.showToast({ message: '评价发布成功' })
              router.back()
            } else {
              promptAction.showToast({ message: '请填写评分和内容' })
            }
          })
      }
      .width('100%')
      .padding(10)

      Column() {
        Text('整体评分')
          .fontSize(14)
          .fontColor('#666')
          .width('100%')
          .margin({ bottom: 8 })
        StarRating({
          rating: this.inputRating,
          readonly: false,
          onRate: (value: number) => {
            this.inputRating = value
          }
        })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin(12)
      .borderRadius(8)

      Column() {
        Text('昵称')
          .fontSize(14)
          .fontColor('#666')
          .width('100%')
          .margin({ bottom: 6 })
        TextInput({ text: this.inputAuthor, placeholder: '请输入你的昵称' })
          .width('100%')
          .height(40)
          .backgroundColor('#F5F5F5')
          .borderRadius(6)
          .padding({ left: 12 })
          .onChange((v) => { this.inputAuthor = v })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12 })
      .borderRadius(8)

      Column() {
        Text('评价内容')
          .fontSize(14)
          .fontColor('#666')
          .width('100%')
          .margin({ bottom: 6 })
        TextArea({ text: this.inputContent, placeholder: '分享你的真实体验，帮助更多人做出选择...' })
          .width('100%')
          .height(160)
          .backgroundColor('#F5F5F5')
          .borderRadius(6)
          .padding(12)
          .onChange((v) => { this.inputContent = v })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin(12)
      .borderRadius(8)

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
