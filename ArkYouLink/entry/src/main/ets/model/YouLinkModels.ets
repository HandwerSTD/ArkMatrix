@ObservedV2
export class ScheduleEvent {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace location: string = ''
  @Trace isImportant: boolean = false

  toJSON(): Record<string, Object> {
    return { time: this.time, title: this.title, location: this.location, isImportant: this.isImportant }
  }

  static fromJSON(data: Record<string, Object>): ScheduleEvent {
    let s: ScheduleEvent = new ScheduleEvent()
    if (data['time'] !== undefined) s.time = data['time'] as string
    if (data['title'] !== undefined) s.title = data['title'] as string
    if (data['location'] !== undefined) s.location = data['location'] as string
    if (data['isImportant'] !== undefined) s.isImportant = data['isImportant'] as boolean
    return s
  }
}

@ObservedV2
export class LeaveRecord {
  @Trace id: string = ''
  @Trace type: string = ''
  @Trace startDate: string = ''
  @Trace endDate: string = ''
  @Trace status: string = ''
  @Trace reason: string = ''

  toJSON(): Record<string, Object> {
    return {
      id: this.id, type: this.type, startDate: this.startDate,
      endDate: this.endDate, status: this.status, reason: this.reason
    }
  }

  static fromJSON(data: Record<string, Object>): LeaveRecord {
    let r: LeaveRecord = new LeaveRecord()
    if (data['id'] !== undefined) r.id = data['id'] as string
    if (data['type'] !== undefined) r.type = data['type'] as string
    if (data['startDate'] !== undefined) r.startDate = data['startDate'] as string
    if (data['endDate'] !== undefined) r.endDate = data['endDate'] as string
    if (data['status'] !== undefined) r.status = data['status'] as string
    if (data['reason'] !== undefined) r.reason = data['reason'] as string
    return r
  }
}

@ObservedV2
export class UserStatus {
  @Trace label: string = '在线'
  @Trace icon: string = '🟢'

  toJSON(): Record<string, Object> {
    return { label: this.label, icon: this.icon }
  }

  static fromJSON(data: Record<string, Object>): UserStatus {
    let s: UserStatus = new UserStatus()
    if (data['label'] !== undefined) s.label = data['label'] as string
    if (data['icon'] !== undefined) s.icon = data['icon'] as string
    return s
  }
}

@ObservedV2
export class AutoReplyRule {
  @Trace isEnabled: boolean = false
  @Trace presetMessage: string = ''

  toJSON(): Record<string, Object> {
    return { isEnabled: this.isEnabled, presetMessage: this.presetMessage }
  }

  static fromJSON(data: Record<string, Object>): AutoReplyRule {
    let r: AutoReplyRule = new AutoReplyRule()
    if (data['isEnabled'] !== undefined) r.isEnabled = data['isEnabled'] as boolean
    if (data['presetMessage'] !== undefined) r.presetMessage = data['presetMessage'] as string
    return r
  }
}
