import { POI, Review, Collection } from '../model/XiaoZhongReviewModels'

let allPOIs: POI[] = []

function initPOIs(): POI[] {
  if (allPOIs.length > 0) return allPOIs
  let p1 = new POI()
  p1.id = 'poi001'
  p1.name = '南京总统府'
  p1.category = '景点'
  p1.rating = 4.7
  p1.reviewCount = 2856
  p1.address = '玄武区长江路292号'
  p1.image = '🏛️'
  p1.isCollected = false
  allPOIs.push(p1)
  let p2 = new POI()
  p2.id = 'poi002'
  p2.name = '李记清真馆'
  p2.category = '美食'
  p2.rating = 4.8
  p2.reviewCount = 3621
  p2.address = '秦淮区评事街打钉巷'
  p2.image = '🥟'
  p2.isCollected = true
  allPOIs.push(p2)
  let p3 = new POI()
  p3.id = 'poi003'
  p3.name = '南京夫子庙'
  p3.category = '景点'
  p3.rating = 4.5
  p3.reviewCount = 4520
  p3.address = '秦淮区夫子庙景区'
  p3.image = '🛕'
  p3.isCollected = false
  allPOIs.push(p3)
  let p4 = new POI()
  p4.id = 'poi004'
  p4.name = '科巷美食街'
  p4.category = '美食'
  p4.rating = 4.4
  p4.reviewCount = 1890
  p4.address = '秦淮区科巷'
  p4.image = '🍜'
  p4.isCollected = false
  allPOIs.push(p4)
  let p5 = new POI()
  p5.id = 'poi005'
  p5.name = '颐和路民国建筑群'
  p5.category = '景点'
  p5.rating = 4.6
  p5.reviewCount = 1234
  p5.address = '鼓楼区颐和路'
  p5.image = '🏘️'
  p5.isCollected = false
  allPOIs.push(p5)
  let p6 = new POI()
  p6.id = 'poi006'
  p6.name = '老门东'
  p6.category = '景点'
  p6.rating = 4.5
  p6.reviewCount = 3100
  p6.address = '秦淮区箍桶巷'
  p6.image = '🏮'
  p6.isCollected = true
  allPOIs.push(p6)
  let p7 = new POI()
  p7.id = 'poi007'
  p7.name = '南京大牌档'
  p7.category = '美食'
  p7.rating = 4.3
  p7.reviewCount = 5230
  p7.address = '秦淮区建康路'
  p7.image = '🍲'
  p7.isCollected = false
  allPOIs.push(p7)
  let p8 = new POI()
  p8.id = 'poi008'
  p8.name = '先锋书店'
  p8.category = '购物'
  p8.rating = 4.7
  p8.reviewCount = 2100
  p8.address = '鼓楼区广州路173号'
  p8.image = '📚'
  p8.isCollected = false
  allPOIs.push(p8)
  return allPOIs
}

export class XiaoZhongReviewMock {
  static searchPOI(query: string, category: string): POI[] {
    let pois = initPOIs()
    let result = pois
    if (query.length > 0) {
      result = result.filter(p => p.name.indexOf(query) >= 0 || p.address.indexOf(query) >= 0)
    }
    if (category.length > 0 && category !== '全部') {
      result = result.filter(p => p.category === category)
    }
    return result
  }

  static getReviews(poiId: string): Review[] {
    let reviews: Review[] = []
    let r1 = new Review()
    r1.author = '旅行达人小王'
    r1.rating = 5
    r1.content = '非常推荐！环境优雅，服务周到，绝对是来南京必打卡的地方。建议避开周末去，人会少很多。'
    r1.date = '2025-06-15'
    reviews.push(r1)
    let r2 = new Review()
    r2.author = '吃货小李'
    r2.rating = 4
    r2.content = '味道确实不错，价格也合理。就是排队时间有点长，建议提前预约。'
    r2.date = '2025-06-10'
    reviews.push(r2)
    let r3 = new Review()
    r3.author = '历史爱好者'
    r3.rating = 5
    r3.content = '历史底蕴深厚，讲解很专业。带父母来的，大家都觉得很值得。'
    r3.date = '2025-06-08'
    reviews.push(r3)
    let r4 = new Review()
    r4.author = '自由行小张'
    r4.rating = 4
    r4.content = '整体不错，但有些区域在修缮。还好大部分区域都能参观。拍照很出片。'
    r4.date = '2025-05-28'
    reviews.push(r4)
    return reviews
  }

  static getCollections(): Collection[] {
    let collections: Collection[] = []
    let c1 = new Collection()
    c1.id = 'col001'
    c1.name = '南京必吃榜'
    c1.poiIds = ['poi002', 'poi004', 'poi007']
    collections.push(c1)
    let c2 = new Collection()
    c2.id = 'col002'
    c2.name = '金陵文化之旅'
    c2.poiIds = ['poi001', 'poi003', 'poi005', 'poi006']
    collections.push(c2)
    return collections
  }

  static getAllPOIs(): POI[] {
    return initPOIs()
  }
}
