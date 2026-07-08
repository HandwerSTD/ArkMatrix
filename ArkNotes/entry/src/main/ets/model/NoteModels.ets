@ObservedV2
export class ChecklistItem {
  @Trace text: string = ''
  @Trace isDone: boolean = false

  toJSON(): Record<string, Object> {
    return { text: this.text, isDone: this.isDone }
  }

  static fromJSON(data: Record<string, Object>): ChecklistItem {
    let c: ChecklistItem = new ChecklistItem()
    if (data['text'] !== undefined) c.text = data['text'] as string
    if (data['isDone'] !== undefined) c.isDone = data['isDone'] as boolean
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

  toJSON(): Record<string, Object> {
    let json: Record<string, Object> = {
      id: this.id, title: this.title, content: this.content,
      date: this.date, tags: this.tags, type: this.type
    }
    json['checklist'] = this.checklist.map((item: ChecklistItem) => item.toJSON())
    return json
  }

  static fromJSON(data: Record<string, Object>): Note {
    let n: Note = new Note()
    if (data['id'] !== undefined) n.id = data['id'] as string
    if (data['title'] !== undefined) n.title = data['title'] as string
    if (data['content'] !== undefined) n.content = data['content'] as string
    if (data['date'] !== undefined) n.date = data['date'] as string
    if (data['tags'] !== undefined) n.tags = data['tags'] as string[]
    if (data['type'] !== undefined) n.type = data['type'] as 'note' | 'checklist'
    if (data['checklist']) {
      let rawItems: Record<string, Object>[] = data['checklist'] as Record<string, Object>[]
      n.checklist = rawItems.map((d: Record<string, Object>) => ChecklistItem.fromJSON(d))
    }
    return n
  }
}
