import { Note } from '../model/NoteModels'

@ComponentV2
export struct ChecklistCard {
  @Param note: Note = new Note()
  @Event onToggle: (noteId: string, itemIdx: number) => void = (noteId: string, itemIdx: number) => {}

  build() {
    Column() {
      Text(this.note.title)
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .width('100%')
      Text(`完成: ${this.note.checklist.filter((item: object) => (item as Record<string, Object>)['isDone']).length}/${this.note.checklist.length} 项`)
        .fontSize(11)
        .fontColor('#999')
        .width('100%')
        .margin({ top: 2, bottom: 8 })
      ForEach(this.note.checklist, (item: object, index: number) => {
        let ci = item as Record<string, Object>
        Row() {
          Checkbox()
            .select(ci['isDone'] as boolean)
            .onChange((value: boolean) => {
              this.onToggle(this.note.id, index)
            })
          Text(ci['text'] as string)
            .fontSize(13)
            .fontColor(ci['isDone'] ? '#BBB' : '#333')
            .decoration({ type: ci['isDone'] ? TextDecorationType.LineThrough : TextDecorationType.None })
            .margin({ left: 8 })
        }
        .width('100%')
        .padding({ top: 4, bottom: 4 })
      })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
  }
}
