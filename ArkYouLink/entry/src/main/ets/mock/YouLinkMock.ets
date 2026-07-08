import { ScheduleEvent, LeaveRecord, UserStatus } from '../model/YouLinkModels'

export class YouLinkMock {
  static getTodaySchedule(): ScheduleEvent[] {
    let events: ScheduleEvent[] = []
    let e1 = new ScheduleEvent()
    e1.time = '10:00-10:30'; e1.title = '团队站会'; e1.location = '线上会议'
    e1.isImportant = true
    events.push(e1)
    let e2 = new ScheduleEvent()
    e2.time = '14:00-15:00'; e2.title = '南京项目需求评审'; e2.location = '3号会议室'
    e2.isImportant = true
    events.push(e2)
    let e3 = new ScheduleEvent()
    e3.time = '16:00-16:30'; e3.title = '周报提交'; e3.location = ''
    e3.isImportant = false
    events.push(e3)
    let e4 = new ScheduleEvent()
    e4.time = '18:00-20:00'; e4.title = '团建聚餐'; e4.location = '新街口XX餐厅'
    e4.isImportant = false
    events.push(e4)
    return events
  }

  static getLeaveRecords(): LeaveRecord[] {
    let records: LeaveRecord[] = []
    let r1 = new LeaveRecord()
    r1.id = 'lv001'; r1.type = '年假'; r1.startDate = '2025-07-14'
    r1.endDate = '2025-07-16'; r1.status = '已审批'; r1.reason = '南京三日游'
    records.push(r1)
    let r2 = new LeaveRecord()
    r2.id = 'lv002'; r2.type = '事假'; r2.startDate = '2025-06-20'
    r2.endDate = '2025-06-20'; r2.status = '已审批'; r2.reason = '办理护照'
    records.push(r2)
    let r3 = new LeaveRecord()
    r3.id = 'lv003'; r3.type = '病假'; r3.startDate = '2025-05-08'
    r3.endDate = '2025-05-09'; r3.status = '已审批'; r3.reason = '感冒发烧'
    records.push(r3)
    return records
  }

  static submitLeave(type: string, reason: string): LeaveRecord {
    let record = new LeaveRecord()
    record.id = 'lv_new_' + Date.now()
    record.type = type
    record.startDate = '2025-07-14'
    record.endDate = '2025-07-16'
    record.status = '审批中'
    record.reason = reason
    return record
  }

  static getStatusOptions(): UserStatus[] {
    let options: UserStatus[] = []
    let s1 = new UserStatus()
    s1.label = '在线'; s1.icon = '🟢'
    options.push(s1)
    let s2 = new UserStatus()
    s2.label = '忙碌'; s2.icon = '🔴'
    options.push(s2)
    let s3 = new UserStatus()
    s3.label = '差旅中'; s3.icon = '✈️'
    options.push(s3)
    return options
  }
}
