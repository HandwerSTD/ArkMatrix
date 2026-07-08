import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local from: string = ''
  @Local to: string = ''
  @Local date: string = ''

  build() {
    Column() {
      Text('行旅纵横')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 6 })

      Column() {
        Text('搜索车票/机票')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .margin({ bottom: 12 })

        Row() {
          Text('出发')
            .fontSize(13)
            .fontColor('#666')
            .width(50)
          TextInput({ text: this.from, placeholder: '北京' })
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .padding({ left: 10 })
            .onChange((v) => { this.from = v })
        }
        .width('100%')

        Row() {
          Text('到达')
            .fontSize(13)
            .fontColor('#666')
            .width(50)
          TextInput({ text: this.to, placeholder: '南京' })
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .padding({ left: 10 })
            .onChange((v) => { this.to = v })
        }
        .width('100%')
        .margin({ top: 8 })

        Row() {
          Text('日期')
            .fontSize(13)
            .fontColor('#666')
            .width(50)
          TextInput({ text: this.date, placeholder: '2025-07-14' })
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .padding({ left: 10 })
            .onChange((v) => { this.date = v })
        }
        .width('100%')
        .margin({ top: 8 })

        Button('搜索')
          .width('100%')
          .height(44)
          .fontSize(15)
          .margin({ top: 14 })
          .borderRadius(22)
          .backgroundColor('#FF6600')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/SearchResult',
              params: { from: this.from, to: this.to, date: this.date }
            })
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 12 })
      .borderRadius(8)

      Row() {
        Column() {
          Text('📋')
            .fontSize(30)
          Text('我的行程')
            .fontSize(12)
            .fontColor('#666')
            .margin({ top: 4 })
        }
        .width('33%')
        .onClick(() => {
          router.pushUrl({ url: 'pages/MyTrips' })
        })
        Column() {
          Text('🔔')
            .fontSize(30)
          Text('延误提醒')
            .fontSize(12)
            .fontColor('#666')
            .margin({ top: 4 })
        }
        .width('33%')
        Column() {
          Text('🎫')
            .fontSize(30)
          Text('常用旅客')
            .fontSize(12)
            .fontColor('#666')
            .margin({ top: 4 })
        }
        .width('34%')
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 12 })
      .borderRadius(8)

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
