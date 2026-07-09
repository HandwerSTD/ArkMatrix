export interface IScheduleEventData {
  time: string
  title: string
  location: string
  isImportant: boolean
}

export interface ILeaveRecordData {
  id: string
  type: string
  startDate: string
  endDate: string
  status: string
  reason: string
}

export interface IUserStatusData {
  label: string
  icon: string
}

export interface IAutoReplyRuleData {
  isEnabled: boolean
  presetMessage: string
}

@ObservedV2
export class ScheduleEvent {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace location: string = ''
  @Trace isImportant: boolean = false

  toJSON(): IScheduleEventData {
    return { time: this.time, title: this.title, location: this.location, isImportant: this.isImportant }
  }

  static fromJSON(data: IScheduleEventData): ScheduleEvent {
    let s: ScheduleEvent = new ScheduleEvent()
    s.time = data.time; s.title = data.title; s.location = data.location; s.isImportant = data.isImportant
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

  toJSON(): ILeaveRecordData {
    return {
      id: this.id, type: this.type, startDate: this.startDate,
      endDate: this.endDate, status: this.status, reason: this.reason
    }
  }

  static fromJSON(data: ILeaveRecordData): LeaveRecord {
    let r: LeaveRecord = new LeaveRecord()
    r.id = data.id; r.type = data.type; r.startDate = data.startDate
    r.endDate = data.endDate; r.status = data.status; r.reason = data.reason
    return r
  }
}

@ObservedV2
export class UserStatus {
  @Trace label: string = '在线'
  @Trace icon: string = '🟢'

  toJSON(): IUserStatusData {
    return { label: this.label, icon: this.icon }
  }

  static fromJSON(data: IUserStatusData): UserStatus {
    let s: UserStatus = new UserStatus()
    s.label = data.label; s.icon = data.icon
    return s
  }
}

@ObservedV2
export class AutoReplyRule {
  @Trace isEnabled: boolean = false
  @Trace presetMessage: string = ''

  toJSON(): IAutoReplyRuleData {
    return { isEnabled: this.isEnabled, presetMessage: this.presetMessage }
  }

  static fromJSON(data: IAutoReplyRuleData): AutoReplyRule {
    let r: AutoReplyRule = new AutoReplyRule()
    r.isEnabled = data.isEnabled; r.presetMessage = data.presetMessage
    return r
  }
}
