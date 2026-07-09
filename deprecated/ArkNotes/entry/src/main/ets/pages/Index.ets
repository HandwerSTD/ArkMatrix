import { Note } from '../model/NoteModels'
import { NotesMock } from '../mock/NotesMock'
import { NoteCard } from '../view/NoteCard'
import { ChecklistCard } from '../view/ChecklistCard'
import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct Index {
  @Local notes: Note[] = NotesMock.getNotes()
  @Local filteredNotes: Note[] = NotesMock.getNotes()
  @Local searchQuery: string = ''
  @Local activeTab: number = 0
  private tabs: string[] = ['全部', '笔记', '清单']

  build() {
    Column() {
      Text('备忘录')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 4 })

      Row() {
        TextInput({ text: this.searchQuery, placeholder: '搜索备忘录...' })
          .layoutWeight(1)
          .height(38)
          .backgroundColor('#F5F5F5')
          .borderRadius(19)
          .padding({ left: 16 })
          .onChange((value: string) => {
            this.searchQuery = value
            this.applyFilters()
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 6 })

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(13)
            .fontColor(this.activeTab === index ? '#FF6600' : '#666')
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .borderRadius(14)
            .backgroundColor(this.activeTab === index ? '#FFF0E6' : '#F0F0F0')
            .margin({ right: 8 })
            .onClick(() => {
              this.activeTab = index
              this.applyFilters()
            })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 4, bottom: 6 })

      List() {
        ForEach(this.filteredNotes, (note: Note) => {
          ListItem() {
            if (note.type === 'checklist') {
              ChecklistCard({
                note: note,
                onToggle: (noteId: string, itemIdx: number) => {
                  let found = this.notes.find((n: Note) => n.id === noteId)
                  if (found && found.checklist[itemIdx]) {
                    found.checklist[itemIdx].isDone = !found.checklist[itemIdx].isDone
                  }
                  this.notes = [...this.notes]
                  this.applyFilters()
                }
              })
            } else {
              NoteCard({
                note: note,
                onItemClick: (id: string) => {
                  router.pushUrl({ url: 'pages/NoteEdit', params: { noteId: id } as Record<string, Object> } as Record<string, Object>)
                }
              })
            }
          }
        })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      Button('+')
        .fontSize(28)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#FF6600')
        .fontColor(Color.White)
        .position({ right: 20, bottom: 20 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/NoteEdit', params: { noteId: '' } as Record<string, Object> } as Record<string, Object>)
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  private applyFilters(): void {
    let result = this.notes
    if (this.activeTab === 1) {
      result = result.filter((n: Note) => n.type === 'note')
    } else if (this.activeTab === 2) {
      result = result.filter((n: Note) => n.type === 'checklist')
    }
    if (this.searchQuery.length > 0) {
      result = result.filter((n: Note) =>
        n.title.indexOf(this.searchQuery) >= 0 || n.content.indexOf(this.searchQuery) >= 0
      )
    }
    this.filteredNotes = result
  }
}
