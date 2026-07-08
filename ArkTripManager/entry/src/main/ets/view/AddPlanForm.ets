import { PlanItem } from '../model/TripModels'

@ComponentV2
export struct AddPlanForm {
  @Local time: string = ''
  @Local title: string = ''
  @Local type: string = '景点'
  @Local location: string = ''
  @Local note: string = ''
  @Event onSubmit: (item: PlanItem) => void = (item: PlanItem) => {}
  private types: string[] = ['交通', '美食', '景点', '购物']

  build() {
    Column() {
      Text('添加行程')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 10 })

      Row() {
        Text('时间')
          .fontSize(13).fontColor('#666').width(50)
        TextInput({ text: this.time, placeholder: '10:00' })
          .layoutWeight(1).height(38).backgroundColor('#F5F5F5')
          .borderRadius(6).padding({ left: 10 })
          .onChange((v: string) => { this.time = v })
      }.width('100%').margin({ bottom: 8 })

      Row() {
        Text('标题')
          .fontSize(13).fontColor('#666').width(50)
        TextInput({ text: this.title, placeholder: '行程名称' })
          .layoutWeight(1).height(38).backgroundColor('#F5F5F5')
          .borderRadius(6).padding({ left: 10 })
          .onChange((v: string) => { this.title = v })
      }.width('100%').margin({ bottom: 8 })

      Row() {
        Text('类型')
          .fontSize(13).fontColor('#666').width(50)
        Row() {
          ForEach(this.types, (t: string) => {
            Text(t)
              .fontSize(12)
              .fontColor(this.type === t ? '#FF6600' : '#666')
              .padding({ left: 10, right: 10, top: 5, bottom: 5 })
              .borderRadius(12)
              .backgroundColor(this.type === t ? '#FFF0E6' : '#F0F0F0')
              .margin({ right: 6 })
              .onClick(() => { this.type = t })
          })
        }
      }.width('100%').margin({ bottom: 8 })

      Row() {
        Text('地点')
          .fontSize(13).fontColor('#666').width(50)
        TextInput({ text: this.location, placeholder: '位置' })
          .layoutWeight(1).height(38).backgroundColor('#F5F5F5')
          .borderRadius(6).padding({ left: 10 })
          .onChange((v: string) => { this.location = v })
      }.width('100%').margin({ bottom: 8 })

      Row() {
        Text('备注')
          .fontSize(13).fontColor('#666').width(50)
        TextInput({ text: this.note, placeholder: '备注信息' })
          .layoutWeight(1).height(38).backgroundColor('#F5F5F5')
          .borderRadius(6).padding({ left: 10 })
          .onChange((v: string) => { this.note = v })
      }.width('100%').margin({ bottom: 12 })

      Button('确认添加')
        .width('100%').height(40).fontSize(14).borderRadius(20)
        .backgroundColor('#FF6600').fontColor(Color.White)
        .onClick(() => {
          if (this.title.length > 0 && this.time.length > 0) {
            let item = new PlanItem()
            item.time = this.time; item.title = this.title
            item.type = this.type; item.location = this.location
            item.note = this.note
            this.onSubmit(item)
          }
        })
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}
