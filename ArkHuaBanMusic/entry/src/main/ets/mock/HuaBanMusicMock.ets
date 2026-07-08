import { Playlist, TravelRadio } from '../model/HuaBanMusicModels'

export class HuaBanMusicMock {
  static getPlaylists(): Playlist[] {
    let playlists: Playlist[] = []
    let p1 = new Playlist()
    p1.id = 'pl001'
    p1.name = '南京城市民谣'
    p1.cover = '🎸'
    p1.songCount = 32
    p1.description = '南京本土音乐人的民谣合集，适合在古城漫步时听'
    p1.songs = ['南京下的雨 - 刘小天', '热河 - 李志', '山阴路的夏天 - 李志', '颐和路 - 木小雅']
    playlists.push(p1)
    let p2 = new Playlist()
    p2.id = 'pl002'
    p2.name = '高铁旅行BGM'
    p2.cover = '🚄'
    p2.songCount = 45
    p2.description = '窗外风景飞驰，耳机里是旅行的节奏'
    p2.songs = ['Traveling Light - Joel Hanson', '500 Miles - The Brothers Four', '坐火车到传说中的湘南海岸 - 陈绮贞']
    playlists.push(p2)
    let p3 = new Playlist()
    p3.id = 'pl003'
    p3.name = '江南烟雨古典'
    p3.cover = '🎋'
    p3.songCount = 28
    p3.description = '一曲琵琶，半城烟雨，江南的味道'
    p3.songs = ['琵琶语 - 林海', '雨碎江南 - 河图', '姑苏行 - 俞逊发']
    playlists.push(p3)
    let p4 = new Playlist()
    p4.id = 'pl004'
    p4.name = '夏日旅行元气'
    p4.cover = '☀️'
    p4.songCount = 36
    p4.description = '充满活力的夏日旅途歌单，让每一步都充满节奏'
    p4.songs = ['Summer - Calvin Harris', '阳光宅男 - 周杰伦', 'Shape of You - Ed Sheeran']
    playlists.push(p4)
    return playlists
  }

  static generateRadio(dest: string): TravelRadio {
    let radio = new TravelRadio()
    radio.destination = dest
    radio.isGenerated = true
    radio.description = `根据目的地${dest}为你生成专属旅途电台`

    if (dest.indexOf('南京') >= 0) {
      radio.mood = '金陵古韵'
      radio.songs = [
        '南京下的雨 - 刘小天',
        '秦淮夜 - 音频怪物',
        '金陵谣 - 银临',
        '热河 - 李志',
        '乌衣巷 - 河图',
        '夜泊秦淮 - 许嵩',
        '南京南京 - 大乔小乔'
      ]
    } else if (dest.indexOf('北京') >= 0) {
      radio.mood = '京城风华'
      radio.songs = [
        '北京北京 - 汪峰',
        '前门情思大碗茶 - 李谷一',
        'One Night in 北京 - 信乐团',
        '钟鼓楼 - 何勇',
        '北京一夜 - 陈升',
        '鼓楼 - 赵雷'
      ]
    } else {
      radio.mood = '旅途愉快'
      radio.songs = [
        '旅行的意义 - 陈绮贞',
        '平凡之路 - 朴树',
        '贝加尔湖畔 - 李健',
        '蓝莲花 - 许巍',
        '成都 - 赵雷',
        '去大理 - 郝云'
      ]
    }
    return radio
  }
}
