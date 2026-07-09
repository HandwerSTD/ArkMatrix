export interface IPoiData {
  id: string
  name: string
  category: string
  rating: number
  reviewCount: number
  address: string
  isCollected: boolean
  image: string
}

export interface IReviewData {
  author: string
  rating: number
  content: string
  date: string
}

export interface ICollectionData {
  id: string
  name: string
  poiIds: string[]
}

@ObservedV2
export class POI {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace category: string = ''
  @Trace rating: number = 0
  @Trace reviewCount: number = 0
  @Trace address: string = ''
  @Trace isCollected: boolean = false
  @Trace image: string = ''

  toJSON(): IPoiData {
    return {
      id: this.id, name: this.name, category: this.category,
      rating: this.rating, reviewCount: this.reviewCount,
      address: this.address, isCollected: this.isCollected, image: this.image
    }
  }

  static fromJSON(data: IPoiData): POI {
    let p: POI = new POI()
    p.id = data.id; p.name = data.name; p.category = data.category
    p.rating = data.rating; p.reviewCount = data.reviewCount
    p.address = data.address; p.isCollected = data.isCollected; p.image = data.image
    return p
  }
}

@ObservedV2
export class Review {
  @Trace author: string = ''
  @Trace rating: number = 0
  @Trace content: string = ''
  @Trace date: string = ''

  toJSON(): IReviewData {
    return { author: this.author, rating: this.rating, content: this.content, date: this.date }
  }

  static fromJSON(data: IReviewData): Review {
    let r: Review = new Review()
    r.author = data.author; r.rating = data.rating; r.content = data.content; r.date = data.date
    return r
  }
}

@ObservedV2
export class Collection {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace poiIds: string[] = []

  toJSON(): ICollectionData {
    return { id: this.id, name: this.name, poiIds: this.poiIds }
  }

  static fromJSON(data: ICollectionData): Collection {
    let c: Collection = new Collection()
    c.id = data.id; c.name = data.name; c.poiIds = data.poiIds
    return c
  }
}
