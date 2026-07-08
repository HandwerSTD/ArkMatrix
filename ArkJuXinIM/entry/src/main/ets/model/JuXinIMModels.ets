@ObservedV2
export class PlanCardData {
  @Trace title: string = ''
  @Trace date: string = ''
  @Trace destination: string = ''
  @Trace ticketInfo: string = ''
  @Trace poiCount: number = 0
}

@ObservedV2
export class Contact {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace avatar: string = ''
  @Trace status: string = ''
  @Trace recentMessage: string = ''
  @Trace recentTime: string = ''
}

@ObservedV2
export class Message {
  @Trace id: string = ''
  @Trace fromId: string = ''
  @Trace content: string = ''
  @Trace time: string = ''
  @Trace isMe: boolean = false
  @Trace isPlanCard: boolean = false
  @Trace planCard: PlanCardData | null = null
}
