import { Note, ChecklistItem } from '../model/NoteModels'

const RAW_NOTES: Record<string, Object>[] = [
  {
    id: 'n001',
    title: '南京旅行打包清单',
    content: '',
    date: '2025-07-13',
    tags: ['旅行', '南京'],
    type: 'checklist',
    checklist: [
      { text: '身份证', isDone: true },
      { text: '充电宝', isDone: true },
      { text: '雨伞', isDone: false },
      { text: '防晒霜', isDone: false },
      { text: '换洗衣物（3天）', isDone: true }
    ]
  },
  {
    id: 'n002',
    title: '李记清真馆锅贴',
    content: '地址：秦淮区评事街打钉巷\n推荐：牛肉锅贴（必点）、牛肉馄饨、牛杂汤\n营业时间：6:00-19:00\nTips: 高峰期排队30分钟+，建议工作日去',
    date: '2025-07-09',
    tags: ['南京', '美食'],
    type: 'note',
    checklist: []
  },
  {
    id: 'n003',
    title: '颐和路骑行路线',
    content: '从颐和路出发 → 宁海路 → 汉口西路 → 山阴路\n全长约3公里，骑行约20分钟\n最佳拍照点：颐和公馆、先锋书店',
    date: '2025-07-08',
    tags: ['南京', '骑行', '拍照'],
    type: 'note',
    checklist: []
  },
  {
    id: 'n004',
    title: '南京三日预算',
    content: '交通：高铁来回 887元\n住宿：两晚 800元\n餐饮：每天200元 × 3 = 600元\n门票：总统府40 + 夫子庙30 = 70元\n总计：~2357元',
    date: '2025-07-07',
    tags: ['旅行', '预算'],
    type: 'note',
    checklist: []
  },
  {
    id: 'n005',
    title: '南京必吃餐厅整理',
    content: '1. 李记清真馆 - 牛肉锅贴\n2. 南京大牌档 - 民国美龄粥、盐水鸭\n3. 奇芳阁 - 牛肉锅贴、小笼包\n4. 永和园 - 鸭血粉丝汤\n5. 刘长兴 - 小笼包',
    date: '2025-07-06',
    tags: ['南京', '美食'],
    type: 'note',
    checklist: []
  },
  {
    id: 'n006',
    title: '高铁参会指南',
    content: 'G123次列车有WiFi覆盖\n建议准备：降噪耳机、笔记本充电宝、移动热点\n高铁工作模式：\n1. 提前下载会议资料\n2. 开启勿扰模式\n3. 使用耳机接入会议',
    date: '2025-07-05',
    tags: ['工作', '旅行'],
    type: 'note',
    checklist: []
  }
]

export class NotesMock {
  static getRawNotes(): Record<string, Object>[] {
    return RAW_NOTES
  }

  static getNotes(): Note[] {
    return RAW_NOTES.map((d: Record<string, Object>) => Note.fromJSON(d))
  }

  static createNote(data: Record<string, Object>): Note {
    let d: Record<string, Object> = {
      id: 'n_new_' + Date.now(),
      title: data['title'] || '',
      content: data['content'] || '',
      date: new Date().toISOString().split('T')[0],
      tags: data['tags'] || [],
      type: data['type'] || 'note',
      checklist: data['checklist'] || []
    }
    return Note.fromJSON(d)
  }
}
