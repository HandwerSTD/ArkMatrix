import { Contact } from '../model/JuXinIMModels'

@ComponentV2
export struct ContactItem {
  @Param contact: Contact = new Contact()
  @Event onClick: (id: string) => void = (id: string) => {}

  build() {
    Row() {
      Text(this.contact.avatar)
        .fontSize(28)
        .width(50)
        .height(50)
        .borderRadius(25)
        .backgroundColor('#E8E8E8')
        .textAlign(TextAlign.Center)
      Column() {
        Row() {
          Text(this.contact.name)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
          if (this.contact.status.length > 0) {
            Text(` [${this.contact.status}]`)
              .fontSize(11)
              .fontColor(this.contact.status === '在线' ? '#44BB44' : '#999')
          }
        }
        Text(this.contact.recentMessage)
          .fontSize(12)
          .fontColor('#999')
          .maxLines(1)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 12 })
      Text(this.contact.recentTime)
        .fontSize(11)
        .fontColor('#BBB')
    }
    .width('100%')
    .padding(12)
    .onClick(() => {
      this.onClick(this.contact.id)
    })
  }
}
