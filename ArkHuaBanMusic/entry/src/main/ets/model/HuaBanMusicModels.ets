@ObservedV2
export class Playlist {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace cover: string = ''
  @Trace songCount: number = 0
  @Trace description: string = ''
  @Trace songs: string[] = []

  toJSON(): Record<string, Object> {
    return {
      id: this.id,
      name: this.name,
      cover: this.cover,
      songCount: this.songCount,
      description: this.description,
      songs: this.songs
    }
  }

  static fromJSON(data: Record<string, Object>): Playlist {
    let p: Playlist = new Playlist()
    if (data['id'] !== undefined) p.id = data['id'] as string
    if (data['name'] !== undefined) p.name = data['name'] as string
    if (data['cover'] !== undefined) p.cover = data['cover'] as string
    if (data['songCount'] !== undefined) p.songCount = data['songCount'] as number
    if (data['description'] !== undefined) p.description = data['description'] as string
    if (data['songs'] !== undefined) p.songs = data['songs'] as string[]
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

  toJSON(): Record<string, Object> {
    return {
      destination: this.destination,
      mood: this.mood,
      songs: this.songs,
      isGenerated: this.isGenerated,
      description: this.description
    }
  }

  static fromJSON(data: Record<string, Object>): TravelRadio {
    let r: TravelRadio = new TravelRadio()
    if (data['destination'] !== undefined) r.destination = data['destination'] as string
    if (data['mood'] !== undefined) r.mood = data['mood'] as string
    if (data['songs'] !== undefined) r.songs = data['songs'] as string[]
    if (data['isGenerated'] !== undefined) r.isGenerated = data['isGenerated'] as boolean
    if (data['description'] !== undefined) r.description = data['description'] as string
    return r
  }
}
