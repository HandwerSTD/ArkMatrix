export interface IChecklistItemData {
  text: string
  isDone: boolean
}

export interface INoteData {
  id: string
  title: string
  content: string
  date: string
  tags: string[]
  type: 'note' | 'checklist'
  checklist: IChecklistItemData[]
}

@ObservedV2
export class ChecklistItem {
  @Trace text: string = ''
  @Trace isDone: boolean = false

  toJSON(): IChecklistItemData {
    return { text: this.text, isDone: this.isDone }
  }

  static fromJSON(data: IChecklistItemData): ChecklistItem {
    let c: ChecklistItem = new ChecklistItem()
    c.text = data.text; c.isDone = data.isDone
    return c
  }
}

@ObservedV2
export class Note {
  @Trace id: string = ''
  @Trace title: string = ''
  @Trace content: string = ''
  @Trace date: string = ''
  @Trace tags: string[] = []
  @Trace type: 'note' | 'checklist' = 'note'
  @Trace checklist: ChecklistItem[] = []

  toJSON(): INoteData {
    return {
      id: this.id, title: this.title, content: this.content,
      date: this.date, tags: this.tags, type: this.type,
      checklist: this.checklist.map((item: ChecklistItem) => item.toJSON())
    }
  }

  static fromJSON(data: INoteData): Note {
    let n: Note = new Note()
    n.id = data.id; n.title = data.title; n.content = data.content
    n.date = data.date; n.tags = data.tags; n.type = data.type
    n.checklist = data.checklist.map((d: IChecklistItemData) => ChecklistItem.fromJSON(d))
    return n
  }
}
