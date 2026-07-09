export interface IPoiData {
  name: string
  type: string
  rating: number
  distance: string
  address: string
  tags: string[]
  isCollected: boolean
}

export interface IRouteData {
  type: string
  duration: string
  distance: string
  traffic: string
  steps: string[]
  hasDelay: boolean
}

@ObservedV2
export class POI {
  @Trace name: string = ''
  @Trace type: string = ''
  @Trace rating: number = 0
  @Trace distance: string = ''
  @Trace address: string = ''
  @Trace tags: string[] = []
  @Trace isCollected: boolean = false

  toJSON(): IPoiData {
    return {
      name: this.name,
      type: this.type,
      rating: this.rating,
      distance: this.distance,
      address: this.address,
      tags: this.tags,
      isCollected: this.isCollected
    }
  }

  static fromJSON(data: IPoiData): POI {
    let p: POI = new POI()
    p.name = data.name
    p.type = data.type
    p.rating = data.rating
    p.distance = data.distance
    p.address = data.address
    p.tags = data.tags
    p.isCollected = data.isCollected
    return p
  }
}

@ObservedV2
export class Route {
  @Trace type: string = ''
  @Trace duration: string = ''
  @Trace distance: string = ''
  @Trace traffic: string = ''
  @Trace steps: string[] = []
  @Trace hasDelay: boolean = false

  toJSON(): IRouteData {
    return {
      type: this.type,
      duration: this.duration,
      distance: this.distance,
      traffic: this.traffic,
      steps: this.steps,
      hasDelay: this.hasDelay
    }
  }

  static fromJSON(data: IRouteData): Route {
    let r: Route = new Route()
    r.type = data.type
    r.duration = data.duration
    r.distance = data.distance
    r.traffic = data.traffic
    r.steps = data.steps
    r.hasDelay = data.hasDelay
    return r
  }
}
