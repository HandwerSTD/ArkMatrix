@ObservedV2
export class ChecklistItem {
  @Trace text: string = ''
  @Trace isDone: boolean = false
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
}
