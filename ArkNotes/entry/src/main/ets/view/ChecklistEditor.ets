import { ChecklistItem } from '../model/NoteModels'

@ComponentV2
export struct ChecklistEditor {
  @Local items: ChecklistItem[] = []
  @Local newItemText: string = ''
  @Event onAdd: (text: string) => void = (text: string) => {}
  @Event onToggle: (idx: number) => void = (idx: number) => {}

  build() {
    Column() {
      Text('清单项目')
        .fontSize(13)
        .fontColor('#666')
        .width('100%')
        .margin({ bottom: 6 })
      ForEach(this.items, (item: object, index: number) => {
        let ci = item as Record<string, Object>
        Row() {
          Checkbox()
            .select(ci['isDone'] as boolean)
            .onChange((value: boolean) => {
              this.onToggle(index)
            })
          Text(ci['text'] as string)
            .fontSize(13)
            .fontColor(ci['isDone'] ? '#BBB' : '#333')
            .decoration({ type: ci['isDone'] ? TextDecorationType.LineThrough : TextDecorationType.None })
            .margin({ left: 8 })
            .layoutWeight(1)
        }
        .width('100%')
        .padding({ top: 3, bottom: 3 })
      })
      Row() {
        TextInput({ text: this.newItemText, placeholder: '添加项目...' })
          .layoutWeight(1)
          .height(36)
          .backgroundColor('#F5F5F5')
          .borderRadius(6)
          .padding({ left: 10 })
          .onChange((v: string) => { this.newItemText = v })
        Button('添加')
          .fontSize(12)
          .height(36)
          .width(56)
          .margin({ left: 8 })
          .borderRadius(6)
          .backgroundColor('#FF6600')
          .fontColor(Color.White)
          .onClick(() => {
            if (this.newItemText.length > 0) {
              this.onAdd(this.newItemText)
              this.newItemText = ''
            }
          })
      }
      .width('100%')
      .margin({ top: 8 })
    }
  }
}
