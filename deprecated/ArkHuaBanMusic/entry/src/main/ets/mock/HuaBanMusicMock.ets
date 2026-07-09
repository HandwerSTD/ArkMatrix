import { Playlist, TravelRadio, IPlaylistData, ITravelRadioData } from '../model/HuaBanMusicModels'

const RAW_PLAYLISTS: IPlaylistData[] = [
  {
    id: 'pl001',
    name: '南京城市民谣',
    cover: '🎸',
    songCount: 32,
    description: '南京本土音乐人的民谣合集，适合在古城漫步时听',
    songs: ['南京下的雨 - 刘小天', '热河 - 李志', '山阴路的夏天 - 李志', '颐和路 - 木小雅']
  },
  {
    id: 'pl002',
    name: '高铁旅行BGM',
    cover: '🚄',
    songCount: 45,
    description: '窗外风景飞驰，耳机里是旅行的节奏',
    songs: ['Traveling Light - Joel Hanson', '500 Miles - The Brothers Four', '坐火车到传说中的湘南海岸 - 陈绮贞']
  },
  {
    id: 'pl003',
    name: '江南烟雨古典',
    cover: '🎋',
    songCount: 28,
    description: '一曲琵琶，半城烟雨，江南的味道',
    songs: ['琵琶语 - 林海', '雨碎江南 - 河图', '姑苏行 - 俞逊发']
  },
  {
    id: 'pl004',
    name: '夏日旅行元气',
    cover: '☀️',
    songCount: 36,
    description: '充满活力的夏日旅途歌单，让每一步都充满节奏',
    songs: ['Summer - Calvin Harris', '阳光宅男 - 周杰伦', 'Shape of You - Ed Sheeran']
  }
]

interface ITravelRadioTemplate {
  mood: string
  songs: string[]
}

const RAW_RADIO_TEMPLATES: Record<string, ITravelRadioTemplate> = {
  '南京': {
    mood: '金陵古韵',
    songs: [
      '南京下的雨 - 刘小天',
      '秦淮夜 - 音频怪物',
      '金陵谣 - 银临',
      '热河 - 李志',
      '乌衣巷 - 河图',
      '夜泊秦淮 - 许嵩',
      '南京南京 - 大乔小乔'
    ]
  },
  '北京': {
    mood: '京城风华',
    songs: [
      '北京北京 - 汪峰',
      '前门情思大碗茶 - 李谷一',
      'One Night in 北京 - 信乐团',
      '钟鼓楼 - 何勇',
      '北京一夜 - 陈升',
      '鼓楼 - 赵雷'
    ]
  },
  'default': {
    mood: '旅途愉快',
    songs: [
      '旅行的意义 - 陈绮贞',
      '平凡之路 - 朴树',
      '贝加尔湖畔 - 李健',
      '蓝莲花 - 许巍',
      '成都 - 赵雷',
      '去大理 - 郝云'
    ]
  }
}

export class HuaBanMusicMock {
  static getRawPlaylists(): IPlaylistData[] {
    return RAW_PLAYLISTS
  }

  static getPlaylists(): Playlist[] {
    return RAW_PLAYLISTS.map((d: IPlaylistData) => Playlist.fromJSON(d))
  }

  static generateRadio(dest: string): TravelRadio {
    let template: ITravelRadioTemplate | undefined = RAW_RADIO_TEMPLATES[dest]
    if (!template) {
      template = RAW_RADIO_TEMPLATES['default']
    }
    let data: ITravelRadioData = {
      destination: dest,
      mood: template.mood,
      songs: template.songs,
      isGenerated: true,
      description: `根据目的地${dest}为你生成专属旅途电台`
    }
    return TravelRadio.fromJSON(data)
  }
}
