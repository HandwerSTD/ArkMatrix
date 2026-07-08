import { Note, ChecklistItem } from '../model/NoteModels'
import { NotesMock } from '../mock/NotesMock'
import { ChecklistEditor } from '../view/ChecklistEditor'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct NoteEdit {
  @Local title: string = ''
  @Local content: string = ''
  @Local type: 'note' | 'checklist' = 'note'
  @Local checklist: ChecklistItem[] = []
  @Local tags: string[] = []
  @Local editingId: string = ''

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, string>
    if (params && params['noteId']) {
      let id = params['noteId'] as string
      if (id.length > 0) {
        let notes = NotesMock.getNotes()
        let found = notes.find((n: Note) => n.id === id)
        if (found) {
          this.editingId = found.id
          this.title = found.title
          this.content = found.content
          this.type = found.type
          let items: ChecklistItem[] = []
          for (let i = 0; i < found.checklist.length; i++) {
            let item = new ChecklistItem()
            item.text = found.checklist[i].text
            item.isDone = found.checklist[i].isDone
            items.push(item)
          }
          this.checklist = items
          this.tags = [...found.tags]
        }
      }
    }
  }

  build() {
    Column() {
      Row() {
        Button('← 取消')
          .fontSize(14)
          .backgroundColor('#00000000')
          .onClick(() => { router.back() })
        Text(this.editingId ? '编辑备忘录' : '新建备忘录')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button('保存')
          .fontSize(14)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#FF6600')
          .fontColor(Color.White)
          .padding({ left: 12, right: 12 })
          .margin({ right: 4 })
          .onClick(() => {
            if (this.title.length > 0) {
              NotesMock.createNote({
                title: this.title, content: this.content,
                type: this.type, checklist: this.checklist,
                tags: this.tags
              })
              promptAction.showToast({ message: '保存成功' })
              router.back()
            } else {
              promptAction.showToast({ message: '请输入标题' })
            }
          })
      }
      .width('100%')
      .padding(10)

      Row() {
        Text('笔记')
          .fontSize(13)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(14)
          .backgroundColor(this.type === 'note' ? '#FFF0E6' : '#F0F0F0')
          .fontColor(this.type === 'note' ? '#FF6600' : '#666')
          .onClick(() => { this.type = 'note' })
        Text('清单')
          .fontSize(13)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(14)
          .backgroundColor(this.type === 'checklist' ? '#FFF0E6' : '#F0F0F0')
          .fontColor(this.type === 'checklist' ? '#FF6600' : '#666')
          .margin({ left: 8 })
          .onClick(() => { this.type = 'checklist' })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 8 })

      Column() {
        TextInput({ text: this.title, placeholder: '标题' })
          .width('100%')
          .height(44)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#00000000')
          .onChange((v: string) => { this.title = v })

        if (this.type === 'note') {
          TextArea({ text: this.content, placeholder: '开始输入...' })
            .width('100%')
            .height(200)
            .backgroundColor('#F5F5F5')
            .borderRadius(6)
            .padding(12)
            .margin({ top: 8 })
            .onChange((v: string) => { this.content = v })
        } else {
          ChecklistEditor({
            items: this.checklist,
            onAdd: (text: string) => {
              let item = new ChecklistItem()
              item.text = text
              item.isDone = false
              this.checklist = [...this.checklist, item]
            },
            onToggle: (idx: number) => {
              if (this.checklist[idx]) {
                this.checklist[idx].isDone = !this.checklist[idx].isDone
              }
              this.checklist = [...this.checklist]
            }
          })
          .margin({ top: 8 })
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .margin({ left: 12, right: 12, top: 6 })
      .borderRadius(8)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
