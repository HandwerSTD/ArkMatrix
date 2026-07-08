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

  toJSON(): Record<string, Object> {
    return {
      id: this.id, name: this.name, category: this.category,
      rating: this.rating, reviewCount: this.reviewCount,
      address: this.address, isCollected: this.isCollected, image: this.image
    }
  }

  static fromJSON(data: Record<string, Object>): POI {
    let p: POI = new POI()
    if (data['id'] !== undefined) p.id = data['id'] as string
    if (data['name'] !== undefined) p.name = data['name'] as string
    if (data['category'] !== undefined) p.category = data['category'] as string
    if (data['rating'] !== undefined) p.rating = data['rating'] as number
    if (data['reviewCount'] !== undefined) p.reviewCount = data['reviewCount'] as number
    if (data['address'] !== undefined) p.address = data['address'] as string
    if (data['isCollected'] !== undefined) p.isCollected = data['isCollected'] as boolean
    if (data['image'] !== undefined) p.image = data['image'] as string
    return p
  }
}

@ObservedV2
export class Review {
  @Trace author: string = ''
  @Trace rating: number = 0
  @Trace content: string = ''
  @Trace date: string = ''

  toJSON(): Record<string, Object> {
    return { author: this.author, rating: this.rating, content: this.content, date: this.date }
  }

  static fromJSON(data: Record<string, Object>): Review {
    let r: Review = new Review()
    if (data['author'] !== undefined) r.author = data['author'] as string
    if (data['rating'] !== undefined) r.rating = data['rating'] as number
    if (data['content'] !== undefined) r.content = data['content'] as string
    if (data['date'] !== undefined) r.date = data['date'] as string
    return r
  }
}

@ObservedV2
export class Collection {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace poiIds: string[] = []

  toJSON(): Record<string, Object> {
    return { id: this.id, name: this.name, poiIds: this.poiIds }
  }

  static fromJSON(data: Record<string, Object>): Collection {
    let c: Collection = new Collection()
    if (data['id'] !== undefined) c.id = data['id'] as string
    if (data['name'] !== undefined) c.name = data['name'] as string
    if (data['poiIds'] !== undefined) c.poiIds = data['poiIds'] as string[]
    return c
  }
}
