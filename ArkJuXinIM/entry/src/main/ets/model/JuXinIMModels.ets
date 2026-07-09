export interface IPlanCardData {
  title: string
  date: string
  destination: string
  ticketInfo: string
  poiCount: number
}

export interface IContactData {
  id: string
  name: string
  avatar: string
  status: string
  recentMessage: string
  recentTime: string
}

export interface IMessageData {
  id: string
  fromId: string
  content: string
  time: string
  isMe: boolean
  isPlanCard: boolean
  planCard: IPlanCardData | null
}

@ObservedV2
export class PlanCardData {
  @Trace title: string = ''
  @Trace date: string = ''
  @Trace destination: string = ''
  @Trace ticketInfo: string = ''
  @Trace poiCount: number = 0

  toJSON(): IPlanCardData {
    return {
      title: this.title, date: this.date, destination: this.destination,
      ticketInfo: this.ticketInfo, poiCount: this.poiCount
    }
  }

  static fromJSON(data: IPlanCardData): PlanCardData {
    let p: PlanCardData = new PlanCardData()
    p.title = data.title; p.date = data.date; p.destination = data.destination
    p.ticketInfo = data.ticketInfo; p.poiCount = data.poiCount
    return p
  }
}

@ObservedV2
export class Contact {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace avatar: string = ''
  @Trace status: string = ''
  @Trace recentMessage: string = ''
  @Trace recentTime: string = ''

  toJSON(): IContactData {
    return {
      id: this.id, name: this.name, avatar: this.avatar,
      status: this.status, recentMessage: this.recentMessage, recentTime: this.recentTime
    }
  }

  static fromJSON(data: IContactData): Contact {
    let c: Contact = new Contact()
    c.id = data.id; c.name = data.name; c.avatar = data.avatar
    c.status = data.status; c.recentMessage = data.recentMessage; c.recentTime = data.recentTime
    return c
  }
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

  toJSON(): IMessageData {
    return {
      id: this.id, fromId: this.fromId, content: this.content,
      time: this.time, isMe: this.isMe, isPlanCard: this.isPlanCard,
      planCard: this.planCard ? this.planCard.toJSON() : null
    }
  }

  static fromJSON(data: IMessageData): Message {
    let m: Message = new Message()
    m.id = data.id; m.fromId = data.fromId; m.content = data.content
    m.time = data.time; m.isMe = data.isMe; m.isPlanCard = data.isPlanCard
    if (data.planCard) {
      m.planCard = PlanCardData.fromJSON(data.planCard)
    }
    return m
  }
}
