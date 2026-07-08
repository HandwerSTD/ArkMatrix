import { ScheduleEvent, LeaveRecord, UserStatus } from '../model/YouLinkModels'

const RAW_SCHEDULE: Record<string, Object>[] = [
  { time: '10:00-10:30', title: '团队站会', location: '线上会议', isImportant: true },
  { time: '14:00-15:00', title: '南京项目需求评审', location: '3号会议室', isImportant: true },
  { time: '16:00-16:30', title: '周报提交', location: '', isImportant: false },
  { time: '18:00-20:00', title: '团建聚餐', location: '新街口XX餐厅', isImportant: false }
]

const RAW_LEAVES: Record<string, Object>[] = [
  { id: 'lv001', type: '年假', startDate: '2025-07-14', endDate: '2025-07-16', status: '已审批', reason: '南京三日游' },
  { id: 'lv002', type: '事假', startDate: '2025-06-20', endDate: '2025-06-20', status: '已审批', reason: '办理护照' },
  { id: 'lv003', type: '病假', startDate: '2025-05-08', endDate: '2025-05-09', status: '已审批', reason: '感冒发烧' }
]

const RAW_STATUS: Record<string, Object>[] = [
  { label: '在线', icon: '🟢' },
  { label: '忙碌', icon: '🔴' },
  { label: '差旅中', icon: '✈️' }
]

export class YouLinkMock {
  static getTodaySchedule(): ScheduleEvent[] {
    return RAW_SCHEDULE.map((d: Record<string, Object>) => ScheduleEvent.fromJSON(d))
  }

  static getLeaveRecords(): LeaveRecord[] {
    return RAW_LEAVES.map((d: Record<string, Object>) => LeaveRecord.fromJSON(d))
  }

  static submitLeave(type: string, reason: string): LeaveRecord {
    let data: Record<string, Object> = {
      id: 'lv_new_' + Date.now(),
      type: type,
      startDate: '2025-07-14',
      endDate: '2025-07-16',
      status: '审批中',
      reason: reason
    }
    return LeaveRecord.fromJSON(data)
  }

  static getStatusOptions(): UserStatus[] {
    return RAW_STATUS.map((d: Record<string, Object>) => UserStatus.fromJSON(d))
  }
}
