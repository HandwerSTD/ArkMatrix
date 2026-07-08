@ObservedV2
export class Playlist {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace cover: string = ''
  @Trace songCount: number = 0
  @Trace description: string = ''
  @Trace songs: string[] = []
}

@ObservedV2
export class TravelRadio {
  @Trace destination: string = ''
  @Trace mood: string = ''
  @Trace songs: string[] = []
  @Trace isGenerated: boolean = false
  @Trace description: string = ''
}
