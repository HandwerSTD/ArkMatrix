import { POI, Route, IPoiData, IRouteData } from '../model/DaDeMapModels'

const RAW_POIS: IPoiData[] = [
  {
    name: '南京夫子庙',
    type: '景点',
    rating: 4.5,
    distance: '1.2km',
    address: '秦淮区夫子庙景区',
    tags: ['热门', '历史文化', '美食'],
    isCollected: false
  },
  {
    name: '南京总统府',
    type: '景点',
    rating: 4.7,
    distance: '2.8km',
    address: '玄武区长江路292号',
    tags: ['历史文化', '建筑', '必去'],
    isCollected: false
  },
  {
    name: '李记清真馆',
    type: '美食',
    rating: 4.8,
    distance: '0.5km',
    address: '秦淮区评事街打钉巷',
    tags: ['清真', '锅贴', '老字号'],
    isCollected: true
  },
  {
    name: '科巷美食街',
    type: '美食',
    rating: 4.4,
    distance: '1.5km',
    address: '秦淮区科巷',
    tags: ['美食街', '小吃', '平价'],
    isCollected: false
  },
  {
    name: '颐和路',
    type: '景点',
    rating: 4.6,
    distance: '3.2km',
    address: '鼓楼区颐和路',
    tags: ['骑行', '民国建筑', '拍照'],
    isCollected: false
  },
  {
    name: '老门东',
    type: '景点',
    rating: 4.5,
    distance: '1.8km',
    address: '秦淮区箍桶巷',
    tags: ['历史街区', '文创', '夜景'],
    isCollected: true
  }
]

const RAW_ROUTES: IRouteData[] = [
  {
    type: '驾车',
    duration: '45分钟',
    distance: '12km',
    traffic: '拥堵',
    steps: ['从北京南路出发', '进入中山东路', '经过新街口环岛', '到达南京南站'],
    hasDelay: true
  },
  {
    type: '公交',
    duration: '55分钟',
    distance: '14km',
    traffic: '畅通',
    steps: ['步行至地铁站', '乘坐3号线（林场方向）', '南京南站下车', '步行至出发层'],
    hasDelay: false
  },
  {
    type: '步行',
    duration: '12分钟',
    distance: '0.8km',
    traffic: '畅通',
    steps: ['从夫子庙出发', '沿中华路向北', '右转进入建康路', '到达目的地'],
    hasDelay: false
  }
]

const RAW_NAV_STEPS: string[] = [
  '1. 沿中华路向北行驶500米',
  '2. 右转进入建康路',
  '3. 直行1.2公里，经过新街口（目前拥堵）',
  '4. 左转进入中山南路',
  '5. 直行800米到达南京南站站前广场',
  '6. 北进站口进入候车大厅'
]

export class DaDeMapMock {
  static getRawPOIs(): IPoiData[] {
    return RAW_POIS
  }

  static getNearbyPOIs(): POI[] {
    return RAW_POIS.map((d: IPoiData) => POI.fromJSON(d))
  }

  static getRoutes(): Route[] {
    return RAW_ROUTES.map((d: IRouteData) => Route.fromJSON(d))
  }

  static getNavigationSteps(): string[] {
    return RAW_NAV_STEPS
  }
}
