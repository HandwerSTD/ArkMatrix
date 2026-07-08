import { POI, Review, Collection } from '../model/XiaoZhongReviewModels'

const RAW_POIS: Record<string, Object>[] = [
  { id: 'poi001', name: '南京总统府', category: '景点', rating: 4.7, reviewCount: 2856, address: '玄武区长江路292号', image: '🏛️', isCollected: false },
  { id: 'poi002', name: '李记清真馆', category: '美食', rating: 4.8, reviewCount: 3621, address: '秦淮区评事街打钉巷', image: '🥟', isCollected: true },
  { id: 'poi003', name: '南京夫子庙', category: '景点', rating: 4.5, reviewCount: 4520, address: '秦淮区夫子庙景区', image: '🛕', isCollected: false },
  { id: 'poi004', name: '科巷美食街', category: '美食', rating: 4.4, reviewCount: 1890, address: '秦淮区科巷', image: '🍜', isCollected: false },
  { id: 'poi005', name: '颐和路民国建筑群', category: '景点', rating: 4.6, reviewCount: 1234, address: '鼓楼区颐和路', image: '🏘️', isCollected: false },
  { id: 'poi006', name: '老门东', category: '景点', rating: 4.5, reviewCount: 3100, address: '秦淮区箍桶巷', image: '🏮', isCollected: true },
  { id: 'poi007', name: '南京大牌档', category: '美食', rating: 4.3, reviewCount: 5230, address: '秦淮区建康路', image: '🍲', isCollected: false },
  { id: 'poi008', name: '先锋书店', category: '购物', rating: 4.7, reviewCount: 2100, address: '鼓楼区广州路173号', image: '📚', isCollected: false }
]

const RAW_REVIEWS: Record<string, Object>[] = [
  { author: '旅行达人小王', rating: 5, content: '非常推荐！环境优雅，服务周到，绝对是来南京必打卡的地方。建议避开周末去，人会少很多。', date: '2025-06-15' },
  { author: '吃货小李', rating: 4, content: '味道确实不错，价格也合理。就是排队时间有点长，建议提前预约。', date: '2025-06-10' },
  { author: '历史爱好者', rating: 5, content: '历史底蕴深厚，讲解很专业。带父母来的，大家都觉得很值得。', date: '2025-06-08' },
  { author: '自由行小张', rating: 4, content: '整体不错，但有些区域在修缮。还好大部分区域都能参观。拍照很出片。', date: '2025-05-28' }
]

const RAW_COLLECTIONS: Record<string, Object>[] = [
  { id: 'col001', name: '南京必吃榜', poiIds: ['poi002', 'poi004', 'poi007'] },
  { id: 'col002', name: '金陵文化之旅', poiIds: ['poi001', 'poi003', 'poi005', 'poi006'] }
]

export class XiaoZhongReviewMock {
  static getRawPOIs(): Record<string, Object>[] {
    return RAW_POIS
  }

  static getAllPOIs(): POI[] {
    return RAW_POIS.map((d: Record<string, Object>) => POI.fromJSON(d))
  }

  static searchPOI(query: string, category: string): POI[] {
    let result: Record<string, Object>[] = RAW_POIS
    if (query.length > 0) {
      result = result.filter((p: Record<string, Object>) =>
        (p['name'] as string).indexOf(query) >= 0 || (p['address'] as string).indexOf(query) >= 0
      )
    }
    if (category.length > 0 && category !== '全部') {
      result = result.filter((p: Record<string, Object>) => p['category'] === category)
    }
    return result.map((d: Record<string, Object>) => POI.fromJSON(d))
  }

  static getReviews(poiId: string): Review[] {
    return RAW_REVIEWS.map((d: Record<string, Object>) => Review.fromJSON(d))
  }

  static getCollections(): Collection[] {
    return RAW_COLLECTIONS.map((d: Record<string, Object>) => Collection.fromJSON(d))
  }
}
