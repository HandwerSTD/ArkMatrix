export interface IPlaylistData {
  id: string
  name: string
  cover: string
  songCount: number
  description: string
  songs: string[]
}

export interface ITravelRadioData {
  destination: string
  mood: string
  songs: string[]
  isGenerated: boolean
  description: string
}

@ObservedV2
export class Playlist {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace cover: string = ''
  @Trace songCount: number = 0
  @Trace description: string = ''
  @Trace songs: string[] = []

  toJSON(): IPlaylistData {
    return {
      id: this.id,
      name: this.name,
      cover: this.cover,
      songCount: this.songCount,
      description: this.description,
      songs: this.songs
    }
  }

  static fromJSON(data: IPlaylistData): Playlist {
    let p: Playlist = new Playlist()
    p.id = data.id
    p.name = data.name
    p.cover = data.cover
    p.songCount = data.songCount
    p.description = data.description
    p.songs = data.songs
    return p
  }
}

@ObservedV2
export class TravelRadio {
  @Trace destination: string = ''
  @Trace mood: string = ''
  @Trace songs: string[] = []
  @Trace isGenerated: boolean = false
  @Trace description: string = ''

  toJSON(): ITravelRadioData {
    return {
      destination: this.destination,
      mood: this.mood,
      songs: this.songs,
      isGenerated: this.isGenerated,
      description: this.description
    }
  }

  static fromJSON(data: ITravelRadioData): TravelRadio {
    let r: TravelRadio = new TravelRadio()
    r.destination = data.destination
    r.mood = data.mood
    r.songs = data.songs
    r.isGenerated = data.isGenerated
    r.description = data.description
    return r
  }
}
