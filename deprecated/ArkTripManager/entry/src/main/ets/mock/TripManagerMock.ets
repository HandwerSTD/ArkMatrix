import { Trip, DailyPlan, PlanItem, ITripData } from '../model/TripModels'

const RAW_TRIPS: ITripData[] = [
  {
    id: 'trip001',
    title: '南京三日游',
    destination: '南京',
    startDate: '2025-07-14',
    endDate: '2025-07-16',
    cover: '🏛️',
    status: '待出发',
    dailyPlans: [
      {
        day: 1, date: '2025-07-14',
        items: [
          { time: '10:00', title: '高铁参会（站会）', type: '交通', location: 'YouLink线上', note: '需准备降噪耳机' },
          { time: '12:00', title: 'G123 北京南→南京南', type: '交通', location: '北京南站', note: '检票口A12' },
          { time: '16:00', title: '夫子庙夜游', type: '景点', location: '秦淮区夫子庙', note: '建议晚上去，灯光很美' },
          { time: '18:30', title: '李记清真馆晚餐', type: '美食', location: '秦淮区评事街', note: '必点牛肉锅贴' }
        ]
      },
      {
        day: 2, date: '2025-07-15',
        items: [
          { time: '08:30', title: '早餐：永和园鸭血粉丝汤', type: '美食', location: '秦淮区', note: '' },
          { time: '09:30', title: '总统府游览', type: '景点', location: '玄武区长江路292号', note: '门票40元，建议2小时' },
          { time: '12:00', title: '科巷美食街午餐', type: '美食', location: '秦淮区科巷', note: '小吃一条街，种类丰富' },
          { time: '14:00', title: '颐和路骑行', type: '景点', location: '鼓楼区颐和路', note: '民国建筑群，拍照圣地' }
        ]
      },
      {
        day: 3, date: '2025-07-16',
        items: [
          { time: '10:00', title: '老门东文创街区', type: '景点', location: '秦淮区箍桶巷', note: '买伴手礼' },
          { time: '13:00', title: '南京大牌档午餐', type: '美食', location: '秦淮区建康路', note: '必点美龄粥' },
          { time: '16:00', title: 'G124 南京南→北京南', type: '交通', location: '南京南站', note: '检票口B5，注意晚点提醒' }
        ]
      }
    ]
  },
  {
    id: 'trip002',
    title: '杭州西湖周末游',
    destination: '杭州',
    startDate: '2025-06-20',
    endDate: '2025-06-21',
    cover: '🏞️',
    status: '已完成',
    dailyPlans: [
      {
        day: 1, date: '2025-06-20',
        items: [
          { time: '09:00', title: '高铁到杭州', type: '交通', location: '杭州东站', note: '' },
          { time: '11:00', title: '西湖环湖步行', type: '景点', location: '西湖景区', note: '断桥→白堤→苏堤' },
          { time: '18:00', title: '外婆家晚餐', type: '美食', location: '湖滨银泰', note: '' }
        ]
      }
    ]
  },
  {
    id: 'trip003',
    title: '成都美食之旅',
    destination: '成都',
    startDate: '2025-08-01',
    endDate: '2025-08-04',
    cover: '🐼',
    status: '待出发',
    dailyPlans: [
      {
        day: 1, date: '2025-08-01',
        items: [
          { time: '10:00', title: '飞机到成都', type: '交通', location: '成都双流机场', note: '' },
          { time: '14:00', title: '宽窄巷子逛吃', type: '景点', location: '青羊区宽窄巷子', note: '' }
        ]
      }
    ]
  }
]

export class TripManagerMock {
  static getRawTrips(): ITripData[] {
    return RAW_TRIPS
  }

  static getTrips(): Trip[] {
    return RAW_TRIPS.map((d: ITripData) => Trip.fromJSON(d))
  }

  static createTrip(data: Record<string, Object>): Trip {
    let d: ITripData = {
      id: 'trip_new_' + Date.now(),
      title: (data['title'] as string) || '',
      destination: (data['destination'] as string) || '',
      startDate: (data['startDate'] as string) || '',
      endDate: (data['endDate'] as string) || '',
      cover: '🗺️',
      status: '待出发',
      dailyPlans: []
    }
    return Trip.fromJSON(d)
  }

  static addPlanItem(tripId: string, day: number, item: PlanItem): void {
  }
}
