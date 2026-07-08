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
}

@ObservedV2
export class Review {
  @Trace author: string = ''
  @Trace rating: number = 0
  @Trace content: string = ''
  @Trace date: string = ''
}

@ObservedV2
export class Collection {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace poiIds: string[] = []
}
