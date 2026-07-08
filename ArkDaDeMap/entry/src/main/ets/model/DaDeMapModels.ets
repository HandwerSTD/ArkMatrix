@ObservedV2
export class POI {
  @Trace name: string = ''
  @Trace type: string = ''
  @Trace rating: number = 0
  @Trace distance: string = ''
  @Trace address: string = ''
  @Trace tags: string[] = []
  @Trace isCollected: boolean = false
}

@ObservedV2
export class Route {
  @Trace type: string = ''
  @Trace duration: string = ''
  @Trace distance: string = ''
  @Trace traffic: string = ''
  @Trace steps: string[] = []
  @Trace hasDelay: boolean = false
}
