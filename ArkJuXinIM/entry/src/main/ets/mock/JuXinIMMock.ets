import { Contact, Message, PlanCardData } from '../model/JuXinIMModels'

export class JuXinIMMock {
  static getContacts(): Contact[] {
    let contacts: Contact[] = []
    let c1 = new Contact()
    c1.id = 'u001'; c1.name = '老王'; c1.avatar = '👨'
    c1.status = '在线'; c1.recentMessage = '好的，南京见！'; c1.recentTime = '14:30'
    contacts.push(c1)
    let c2 = new Contact()
    c2.id = 'u002'; c2.name = '旅友小张'; c2.avatar = '👩'
    c2.status = '在线'; c2.recentMessage = '你上次推荐的李记清真馆超赞'; c2.recentTime = '昨天'
    contacts.push(c2)
    let c3 = new Contact()
    c3.id = 'u003'; c3.name = '妈妈'; c3.avatar = '👩‍🦰'
    c3.status = '离线'; c3.recentMessage = '路上注意安全'; c3.recentTime = '周一'
    contacts.push(c3)
    let c4 = new Contact()
    c4.id = 'u004'; c4.name = '同事小李'; c4.avatar = '🧑‍💼'
    c4.status = '忙碌'; c4.recentMessage = '[旅行计划卡片]'; c4.recentTime = '12:00'
    contacts.push(c4)
    let c5 = new Contact()
    c5.id = 'u005'; c5.name = '旅行群·南京小分队'; c5.avatar = '👥'
    c5.status = ''; c5.recentMessage = '小李: 到了发定位'; c5.recentTime = '10:20'
    contacts.push(c5)
    let c6 = new Contact()
    c6.id = 'u006'; c6.name = '高铁管家'; c6.avatar = '🚄'
    c6.status = ''; c6.recentMessage = 'G123次列车已开始检票，检票口A12'; c6.recentTime = '11:45'
    contacts.push(c6)
    let c7 = new Contact()
    c7.id = 'u007'; c7.name = '酒店客服'; c7.avatar = '🏨'
    c7.status = '在线'; c7.recentMessage = '已为您预留大床房，入住时间14:00'; c7.recentTime = '昨天'
    contacts.push(c7)
    let c8 = new Contact()
    c8.id = 'u008'; c8.name = '大伟'; c8.avatar = '🧔'
    c8.status = '在线'; c8.recentMessage = '周末一起吃饭？'; c8.recentTime = '周五'
    contacts.push(c8)
    return contacts
  }

  static getMessages(contactId: string): Message[] {
    let msgs: Message[] = []
    let m1 = new Message()
    m1.id = 'm001'; m1.fromId = 'u001'; m1.content = '小李，你那个南京旅行计划定好了吗？'
    m1.time = '14:20'; m1.isMe = false
    msgs.push(m1)
    let m2 = new Message()
    m2.id = 'm002'; m2.fromId = 'me'; m2.content = '定好啦！小艺帮我规划的，三天两夜，吃喝玩乐都有'
    m2.time = '14:22'; m2.isMe = true
    msgs.push(m2)
    let m3 = new Message()
    m3.id = 'm003'; m3.fromId = 'me'; m3.content = '发你旅行计划卡看看~'
    m3.time = '14:22'; m3.isMe = true
    msgs.push(m3)
    let m4 = new Message()
    m4.id = 'm004'; m4.fromId = 'me'; m4.content = ''
    m4.time = '14:23'; m4.isMe = true; m4.isPlanCard = true
    let card = new PlanCardData()
    card.title = '南京三日游'
    card.date = '2025年7月14日-16日'
    card.destination = '南京'
    card.ticketInfo = 'G123 北京南→南京南 12:00出发'
    card.poiCount = 8
    m4.planCard = card
    msgs.push(m4)
    let m5 = new Message()
    m5.id = 'm005'; m5.fromId = 'u001'; m5.content = '看起来很棒！我看看时间能不能调整一下，争取一起去'
    m5.time = '14:28'; m5.isMe = false
    msgs.push(m5)
    let m6 = new Message()
    m6.id = 'm006'; m6.fromId = 'u001'; m6.content = '好的，南京见！'
    m6.time = '14:30'; m6.isMe = false
    msgs.push(m6)
    return msgs
  }
}
