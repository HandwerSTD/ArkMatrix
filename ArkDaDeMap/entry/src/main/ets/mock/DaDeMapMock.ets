import { POI, Route } from '../model/DaDeMapModels'

export class DaDeMapMock {
  static getNearbyPOIs(): POI[] {
    let pois: POI[] = []
    let p1 = new POI()
    p1.name = '南京夫子庙'
    p1.type = '景点'
    p1.rating = 4.5
    p1.distance = '1.2km'
    p1.address = '秦淮区夫子庙景区'
    p1.tags = ['热门', '历史文化', '美食']
    p1.isCollected = false
    pois.push(p1)
    let p2 = new POI()
    p2.name = '南京总统府'
    p2.type = '景点'
    p2.rating = 4.7
    p2.distance = '2.8km'
    p2.address = '玄武区长江路292号'
    p2.tags = ['历史文化', '建筑', '必去']
    p2.isCollected = false
    pois.push(p2)
    let p3 = new POI()
    p3.name = '李记清真馆'
    p3.type = '美食'
    p3.rating = 4.8
    p3.distance = '0.5km'
    p3.address = '秦淮区评事街打钉巷'
    p3.tags = ['清真', '锅贴', '老字号']
    p3.isCollected = true
    pois.push(p3)
    let p4 = new POI()
    p4.name = '科巷美食街'
    p4.type = '美食'
    p4.rating = 4.4
    p4.distance = '1.5km'
    p4.address = '秦淮区科巷'
    p4.tags = ['美食街', '小吃', '平价']
    p4.isCollected = false
    pois.push(p4)
    let p5 = new POI()
    p5.name = '颐和路'
    p5.type = '景点'
    p5.rating = 4.6
    p5.distance = '3.2km'
    p5.address = '鼓楼区颐和路'
    p5.tags = ['骑行', '民国建筑', '拍照']
    p5.isCollected = false
    pois.push(p5)
    let p6 = new POI()
    p6.name = '老门东'
    p6.type = '景点'
    p6.rating = 4.5
    p6.distance = '1.8km'
    p6.address = '秦淮区箍桶巷'
    p6.tags = ['历史街区', '文创', '夜景']
    p6.isCollected = true
    pois.push(p6)
    return pois
  }

  static getRoutes(): Route[] {
    let routes: Route[] = []
    let r1 = new Route()
    r1.type = '驾车'
    r1.duration = '45分钟'
    r1.distance = '12km'
    r1.traffic = '拥堵'
    r1.steps = ['从北京南路出发', '进入中山东路', '经过新街口环岛', '到达南京南站']
    r1.hasDelay = true
    routes.push(r1)
    let r2 = new Route()
    r2.type = '公交'
    r2.duration = '55分钟'
    r2.distance = '14km'
    r2.traffic = '畅通'
    r2.steps = ['步行至地铁站', '乘坐3号线（林场方向）', '南京南站下车', '步行至出发层']
    r2.hasDelay = false
    routes.push(r2)
    let r3 = new Route()
    r3.type = '步行'
    r3.duration = '12分钟'
    r3.distance = '0.8km'
    r3.traffic = '畅通'
    r3.steps = ['从夫子庙出发', '沿中华路向北', '右转进入建康路', '到达目的地']
    r3.hasDelay = false
    routes.push(r3)
    return routes
  }

  static getNavigationSteps(): string[] {
    return [
      '1. 沿中华路向北行驶500米',
      '2. 右转进入建康路',
      '3. 直行1.2公里，经过新街口（目前拥堵）',
      '4. 左转进入中山南路',
      '5. 直行800米到达南京南站站前广场',
      '6. 北进站口进入候车大厅'
    ]
  }
}
