import { Trip, DailyPlan, PlanItem } from '../model/TripModels'

export class TripManagerMock {
  static getTrips(): Trip[] {
    let trips: Trip[] = []
    let trip1 = new Trip()
    trip1.id = 'trip001'; trip1.title = '南京三日游'
    trip1.destination = '南京'; trip1.startDate = '2025-07-14'
    trip1.endDate = '2025-07-16'; trip1.cover = '🏛️'
    trip1.status = '待出发'
    let dp1 = new DailyPlan()
    dp1.day = 1; dp1.date = '2025-07-14'
    let pi1 = new PlanItem(); pi1.time = '10:00'; pi1.title = '高铁参会（站会）'; pi1.type = '交通'; pi1.location = 'YouLink线上'; pi1.note = '需准备降噪耳机'; dp1.items.push(pi1)
    let pi2 = new PlanItem(); pi2.time = '12:00'; pi2.title = 'G123 北京南→南京南'; pi2.type = '交通'; pi2.location = '北京南站'; pi2.note = '检票口A12'; dp1.items.push(pi2)
    let pi3 = new PlanItem(); pi3.time = '16:00'; pi3.title = '夫子庙夜游'; pi3.type = '景点'; pi3.location = '秦淮区夫子庙'; pi3.note = '建议晚上去，灯光很美'; dp1.items.push(pi3)
    let pi4 = new PlanItem(); pi4.time = '18:30'; pi4.title = '李记清真馆晚餐'; pi4.type = '美食'; pi4.location = '秦淮区评事街'; pi4.note = '必点牛肉锅贴'; dp1.items.push(pi4)
    trip1.dailyPlans.push(dp1)
    let dp2 = new DailyPlan()
    dp2.day = 2; dp2.date = '2025-07-15'
    let pi5 = new PlanItem(); pi5.time = '08:30'; pi5.title = '早餐：永和园鸭血粉丝汤'; pi5.type = '美食'; pi5.location = '秦淮区'; pi5.note = ''; dp2.items.push(pi5)
    let pi6 = new PlanItem(); pi6.time = '09:30'; pi6.title = '总统府游览'; pi6.type = '景点'; pi6.location = '玄武区长江路292号'; pi6.note = '门票40元，建议2小时'; dp2.items.push(pi6)
    let pi7 = new PlanItem(); pi7.time = '12:00'; pi7.title = '科巷美食街午餐'; pi7.type = '美食'; pi7.location = '秦淮区科巷'; pi7.note = '小吃一条街，种类丰富'; dp2.items.push(pi7)
    let pi8 = new PlanItem(); pi8.time = '14:00'; pi8.title = '颐和路骑行'; pi8.type = '景点'; pi8.location = '鼓楼区颐和路'; pi8.note = '民国建筑群，拍照圣地'; dp2.items.push(pi8)
    trip1.dailyPlans.push(dp2)
    let dp3 = new DailyPlan()
    dp3.day = 3; dp3.date = '2025-07-16'
    let pi9 = new PlanItem(); pi9.time = '10:00'; pi9.title = '老门东文创街区'; pi9.type = '景点'; pi9.location = '秦淮区箍桶巷'; pi9.note = '买伴手礼'; dp3.items.push(pi9)
    let pi10 = new PlanItem(); pi10.time = '13:00'; pi10.title = '南京大牌档午餐'; pi10.type = '美食'; pi10.location = '秦淮区建康路'; pi10.note = '必点美龄粥'; dp3.items.push(pi10)
    let pi11 = new PlanItem(); pi11.time = '16:00'; pi11.title = 'G124 南京南→北京南'; pi11.type = '交通'; pi11.location = '南京南站'; pi11.note = '检票口B5，注意晚点提醒'; dp3.items.push(pi11)
    trip1.dailyPlans.push(dp3)
    trips.push(trip1)
    let trip2 = new Trip()
    trip2.id = 'trip002'; trip2.title = '杭州西湖周末游'
    trip2.destination = '杭州'; trip2.startDate = '2025-06-20'
    trip2.endDate = '2025-06-21'; trip2.cover = '🏞️'
    trip2.status = '已完成'
    let dp4 = new DailyPlan(); dp4.day = 1; dp4.date = '2025-06-20'
    let pi12 = new PlanItem(); pi12.time = '09:00'; pi12.title = '高铁到杭州'; pi12.type = '交通'; pi12.location = '杭州东站'; pi12.note = ''; dp4.items.push(pi12)
    let pi13 = new PlanItem(); pi13.time = '11:00'; pi13.title = '西湖环湖步行'; pi13.type = '景点'; pi13.location = '西湖景区'; pi13.note = '断桥→白堤→苏堤'; dp4.items.push(pi13)
    let pi14 = new PlanItem(); pi14.time = '18:00'; pi14.title = '外婆家晚餐'; pi14.type = '美食'; pi14.location = '湖滨银泰'; pi14.note = ''; dp4.items.push(pi14)
    trip2.dailyPlans.push(dp4)
    trips.push(trip2)
    let trip3 = new Trip()
    trip3.id = 'trip003'; trip3.title = '成都美食之旅'
    trip3.destination = '成都'; trip3.startDate = '2025-08-01'
    trip3.endDate = '2025-08-04'; trip3.cover = '🐼'
    trip3.status = '待出发'
    let dp5 = new DailyPlan(); dp5.day = 1; dp5.date = '2025-08-01'
    let pi15 = new PlanItem(); pi15.time = '10:00'; pi15.title = '飞机到成都'; pi15.type = '交通'; pi15.location = '成都双流机场'; pi15.note = ''; dp5.items.push(pi15)
    let pi16 = new PlanItem(); pi16.time = '14:00'; pi16.title = '宽窄巷子逛吃'; pi16.type = '景点'; pi16.location = '青羊区宽窄巷子'; pi16.note = ''; dp5.items.push(pi16)
    trip3.dailyPlans.push(dp5)
    trips.push(trip3)
    return trips
  }

  static createTrip(data: object): Trip {
    let trip = new Trip()
    trip.id = 'trip_new_' + Date.now()
    let d = data as Record<string, Object>
    if (d['title']) trip.title = d['title'] as string
    if (d['destination']) trip.destination = d['destination'] as string
    if (d['startDate']) trip.startDate = d['startDate'] as string
    if (d['endDate']) trip.endDate = d['endDate'] as string
    trip.cover = '🗺️'
    trip.status = '待出发'
    trip.dailyPlans = []
    return trip
  }

  static addPlanItem(tripId: string, day: number, item: PlanItem): void {
  }
}
