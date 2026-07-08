import { Note, ChecklistItem } from '../model/NoteModels'

export class NotesMock {
  static getNotes(): Note[] {
    let notes: Note[] = []
    let n1 = new Note()
    n1.id = 'n001'; n1.title = '南京旅行打包清单'
    n1.content = ''; n1.date = '2025-07-13'; n1.tags = ['旅行', '南京']
    n1.type = 'checklist'
    let c1 = new ChecklistItem(); c1.text = '身份证'; c1.isDone = true
    n1.checklist.push(c1)
    let c2 = new ChecklistItem(); c2.text = '充电宝'; c2.isDone = true
    n1.checklist.push(c2)
    let c3 = new ChecklistItem(); c3.text = '雨伞'; c3.isDone = false
    n1.checklist.push(c3)
    let c4 = new ChecklistItem(); c4.text = '防晒霜'; c4.isDone = false
    n1.checklist.push(c4)
    let c5 = new ChecklistItem(); c5.text = '换洗衣物（3天）'; c5.isDone = true
    n1.checklist.push(c5)
    notes.push(n1)
    let n2 = new Note()
    n2.id = 'n002'; n2.title = '李记清真馆锅贴'
    n2.content = '地址：秦淮区评事街打钉巷\n推荐：牛肉锅贴（必点）、牛肉馄饨、牛杂汤\n营业时间：6:00-19:00\nTips: 高峰期排队30分钟+，建议工作日去'
    n2.date = '2025-07-09'; n2.tags = ['南京', '美食']; n2.type = 'note'
    notes.push(n2)
    let n3 = new Note()
    n3.id = 'n003'; n3.title = '颐和路骑行路线'
    n3.content = '从颐和路出发 → 宁海路 → 汉口西路 → 山阴路\n全长约3公里，骑行约20分钟\n最佳拍照点：颐和公馆、先锋书店'
    n3.date = '2025-07-08'; n3.tags = ['南京', '骑行', '拍照']; n3.type = 'note'
    notes.push(n3)
    let n4 = new Note()
    n4.id = 'n004'; n4.title = '南京三日预算'
    n4.content = '交通：高铁来回 887元\n住宿：两晚 800元\n餐饮：每天200元 × 3 = 600元\n门票：总统府40 + 夫子庙30 = 70元\n总计：~2357元'
    n4.date = '2025-07-07'; n4.tags = ['旅行', '预算']; n4.type = 'note'
    notes.push(n4)
    let n5 = new Note()
    n5.id = 'n005'; n5.title = '南京必吃餐厅整理'
    n5.content = '1. 李记清真馆 - 牛肉锅贴\n2. 南京大牌档 - 民国美龄粥、盐水鸭\n3. 奇芳阁 - 牛肉锅贴、小笼包\n4. 永和园 - 鸭血粉丝汤\n5. 刘长兴 - 小笼包'
    n5.date = '2025-07-06'; n5.tags = ['南京', '美食']; n5.type = 'note'
    notes.push(n5)
    let n6 = new Note()
    n6.id = 'n006'; n6.title = '高铁参会指南'
    n6.content = 'G123次列车有WiFi覆盖\n建议准备：降噪耳机、笔记本充电宝、移动热点\n高铁工作模式：\n1. 提前下载会议资料\n2. 开启勿扰模式\n3. 使用耳机接入会议'
    n6.date = '2025-07-05'; n6.tags = ['工作', '旅行']; n6.type = 'note'
    notes.push(n6)
    return notes
  }

  static createNote(data: object): Note {
    let note = new Note()
    note.id = 'n_new_' + Date.now()
    let d = data as Record<string, Object>
    if (d['title']) note.title = d['title'] as string
    if (d['content']) note.content = d['content'] as string
    note.date = new Date().toISOString().split('T')[0]
    if (d['tags']) note.tags = d['tags'] as string[]
    if (d['type']) note.type = d['type'] as 'note' | 'checklist'
    if (d['checklist']) note.checklist = d['checklist'] as ChecklistItem[]
    return note
  }
}
