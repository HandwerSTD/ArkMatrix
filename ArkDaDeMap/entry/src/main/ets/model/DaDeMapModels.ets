@ObservedV2
export class POI {
  @Trace name: string = ''
  @Trace type: string = ''
  @Trace rating: number = 0
  @Trace distance: string = ''
  @Trace address: string = ''
  @Trace tags: string[] = []
  @Trace isCollected: boolean = false

  toJSON(): Record<string, Object> {
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

  static fromJSON(data: Record<string, Object>): POI {
    let p: POI = new POI()
    if (data['name'] !== undefined) p.name = data['name'] as string
    if (data['type'] !== undefined) p.type = data['type'] as string
    if (data['rating'] !== undefined) p.rating = data['rating'] as number
    if (data['distance'] !== undefined) p.distance = data['distance'] as string
    if (data['address'] !== undefined) p.address = data['address'] as string
    if (data['tags'] !== undefined) p.tags = data['tags'] as string[]
    if (data['isCollected'] !== undefined) p.isCollected = data['isCollected'] as boolean
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

  toJSON(): Record<string, Object> {
    return {
      type: this.type,
      duration: this.duration,
      distance: this.distance,
      traffic: this.traffic,
      steps: this.steps,
      hasDelay: this.hasDelay
    }
  }

  static fromJSON(data: Record<string, Object>): Route {
    let r: Route = new Route()
    if (data['type'] !== undefined) r.type = data['type'] as string
    if (data['duration'] !== undefined) r.duration = data['duration'] as string
    if (data['distance'] !== undefined) r.distance = data['distance'] as string
    if (data['traffic'] !== undefined) r.traffic = data['traffic'] as string
    if (data['steps'] !== undefined) r.steps = data['steps'] as string[]
    if (data['hasDelay'] !== undefined) r.hasDelay = data['hasDelay'] as boolean
    return r
  }
}
