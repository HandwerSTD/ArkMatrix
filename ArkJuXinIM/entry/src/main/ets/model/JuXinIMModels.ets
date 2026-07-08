@ObservedV2
export class PlanCardData {
  @Trace title: string = ''
  @Trace date: string = ''
  @Trace destination: string = ''
  @Trace ticketInfo: string = ''
  @Trace poiCount: number = 0

  toJSON(): Record<string, Object> {
    return {
      title: this.title, date: this.date, destination: this.destination,
      ticketInfo: this.ticketInfo, poiCount: this.poiCount
    }
  }

  static fromJSON(data: Record<string, Object>): PlanCardData {
    let p: PlanCardData = new PlanCardData()
    if (data['title'] !== undefined) p.title = data['title'] as string
    if (data['date'] !== undefined) p.date = data['date'] as string
    if (data['destination'] !== undefined) p.destination = data['destination'] as string
    if (data['ticketInfo'] !== undefined) p.ticketInfo = data['ticketInfo'] as string
    if (data['poiCount'] !== undefined) p.poiCount = data['poiCount'] as number
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

  toJSON(): Record<string, Object> {
    return {
      id: this.id, name: this.name, avatar: this.avatar,
      status: this.status, recentMessage: this.recentMessage, recentTime: this.recentTime
    }
  }

  static fromJSON(data: Record<string, Object>): Contact {
    let c: Contact = new Contact()
    if (data['id'] !== undefined) c.id = data['id'] as string
    if (data['name'] !== undefined) c.name = data['name'] as string
    if (data['avatar'] !== undefined) c.avatar = data['avatar'] as string
    if (data['status'] !== undefined) c.status = data['status'] as string
    if (data['recentMessage'] !== undefined) c.recentMessage = data['recentMessage'] as string
    if (data['recentTime'] !== undefined) c.recentTime = data['recentTime'] as string
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

  toJSON(): Record<string, Object> {
    let json: Record<string, Object> = {
      id: this.id, fromId: this.fromId, content: this.content,
      time: this.time, isMe: this.isMe, isPlanCard: this.isPlanCard
    }
    if (this.planCard) {
      json['planCard'] = this.planCard.toJSON()
    } else {
      json['planCard'] = null
    }
    return json
  }

  static fromJSON(data: Record<string, Object>): Message {
    let m: Message = new Message()
    if (data['id'] !== undefined) m.id = data['id'] as string
    if (data['fromId'] !== undefined) m.fromId = data['fromId'] as string
    if (data['content'] !== undefined) m.content = data['content'] as string
    if (data['time'] !== undefined) m.time = data['time'] as string
    if (data['isMe'] !== undefined) m.isMe = data['isMe'] as boolean
    if (data['isPlanCard'] !== undefined) m.isPlanCard = data['isPlanCard'] as boolean
    if (data['planCard']) {
      m.planCard = PlanCardData.fromJSON(data['planCard'] as Record<string, Object>)
    }
    return m
  }
}
