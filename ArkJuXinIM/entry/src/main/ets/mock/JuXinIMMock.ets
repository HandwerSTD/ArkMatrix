import { Contact, Message, PlanCardData } from '../model/JuXinIMModels'

const RAW_CONTACTS: Record<string, Object>[] = [
  { id: 'u001', name: '老王', avatar: '👨', status: '在线', recentMessage: '好的，南京见！', recentTime: '14:30' },
  { id: 'u002', name: '旅友小张', avatar: '👩', status: '在线', recentMessage: '你上次推荐的李记清真馆超赞', recentTime: '昨天' },
  { id: 'u003', name: '妈妈', avatar: '👩‍🦰', status: '离线', recentMessage: '路上注意安全', recentTime: '周一' },
  { id: 'u004', name: '同事小李', avatar: '🧑‍💼', status: '忙碌', recentMessage: '[旅行计划卡片]', recentTime: '12:00' },
  { id: 'u005', name: '旅行群·南京小分队', avatar: '👥', status: '', recentMessage: '小李: 到了发定位', recentTime: '10:20' },
  { id: 'u006', name: '高铁管家', avatar: '🚄', status: '', recentMessage: 'G123次列车已开始检票，检票口A12', recentTime: '11:45' },
  { id: 'u007', name: '酒店客服', avatar: '🏨', status: '在线', recentMessage: '已为您预留大床房，入住时间14:00', recentTime: '昨天' },
  { id: 'u008', name: '大伟', avatar: '🧔', status: '在线', recentMessage: '周末一起吃饭？', recentTime: '周五' }
]

export class JuXinIMMock {
  static getRawContacts(): Record<string, Object>[] {
    return RAW_CONTACTS
  }

  static getContacts(): Contact[] {
    return RAW_CONTACTS.map((d: Record<string, Object>) => Contact.fromJSON(d))
  }

  static getMessages(contactId: string): Message[] {
    let raw: Record<string, Object>[] = [
      { id: 'm001', fromId: 'u001', content: '小李，你那个南京旅行计划定好了吗？', time: '14:20', isMe: false, isPlanCard: false, planCard: null },
      { id: 'm002', fromId: 'me', content: '定好啦！小艺帮我规划的，三天两夜，吃喝玩乐都有', time: '14:22', isMe: true, isPlanCard: false, planCard: null },
      { id: 'm003', fromId: 'me', content: '发你旅行计划卡看看~', time: '14:22', isMe: true, isPlanCard: false, planCard: null },
      {
        id: 'm004', fromId: 'me', content: '', time: '14:23', isMe: true, isPlanCard: true,
        planCard: {
          title: '南京三日游', date: '2025年7月14日-16日', destination: '南京',
          ticketInfo: 'G123 北京南→南京南 12:00出发', poiCount: 8
        }
      },
      { id: 'm005', fromId: 'u001', content: '看起来很棒！我看看时间能不能调整一下，争取一起去', time: '14:28', isMe: false, isPlanCard: false, planCard: null },
      { id: 'm006', fromId: 'u001', content: '好的，南京见！', time: '14:30', isMe: false, isPlanCard: false, planCard: null }
    ]
    return raw.map((d: Record<string, Object>) => Message.fromJSON(d))
  }
}
