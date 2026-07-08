@ObservedV2
export class ScheduleEvent {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace location: string = ''
  @Trace isImportant: boolean = false
}

@ObservedV2
export class LeaveRecord {
  @Trace id: string = ''
  @Trace type: string = ''
  @Trace startDate: string = ''
  @Trace endDate: string = ''
  @Trace status: string = ''
  @Trace reason: string = ''
}

@ObservedV2
export class UserStatus {
  @Trace label: string = '在线'
  @Trace icon: string = '🟢'
}

@ObservedV2
export class AutoReplyRule {
  @Trace isEnabled: boolean = false
  @Trace presetMessage: string = ''
}
