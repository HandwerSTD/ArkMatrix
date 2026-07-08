import { Note } from '../model/NoteModels'

@ComponentV2
export struct NoteCard {
  @Param note: Note = new Note()
  @Event onClick: (id: string) => void = (id: string) => {}

  build() {
    Column() {
      Text(this.note.title)
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .maxLines(1)
      if (this.note.content.length > 0) {
        Text(this.note.content)
          .fontSize(12)
          .fontColor('#999')
          .width('100%')
          .maxLines(2)
          .margin({ top: 4 })
      }
      Row() {
        Text(this.note.date)
          .fontSize(11)
          .fontColor('#BBB')
        Blank()
        ForEach(this.note.tags, (tag: string) => {
          Text(tag)
            .fontSize(10)
            .fontColor('#FF6600')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor('#FFF0E6')
            .borderRadius(3)
            .margin({ left: 4 })
        })
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
    .onClick(() => {
      this.onClick(this.note.id)
    })
  }
}
