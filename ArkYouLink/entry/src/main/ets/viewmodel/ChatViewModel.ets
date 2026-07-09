import { Message, MessageRole, ContentType } from '../protocol/Message'
import { IMessageConnector, ConnectionState } from '../protocol/IMessageConnector'
import { MockConnector } from '../connector/MockConnector'
import { preferences } from '@kit.ArkData'
import { hilog } from '@kit.PerformanceAnalysisKit'

const PREF_NAME = 'chat_settings'
const KEY_CONNECTION_URL = 'connection_url'
const DOMAIN = 0x0001

@ObservedV2
export class ChatViewModel {
  @Trace messages: Message[] = []
  @Trace connectionState: ConnectionState = ConnectionState.Idle
  @Trace connectionUrl: string = 'mock://default'
  private connector: IMessageConnector = new MockConnector()
  private dataPreferences?: preferences.Preferences

  async init(): Promise<void> {
    this.dataPreferences = preferences.getPreferencesSync(getContext(), { name: PREF_NAME })
    this.connectionUrl = this.dataPreferences.getSync(KEY_CONNECTION_URL, 'mock://default') as string

    this.connector.onMessage((msg: Message) => {
      this.messages = [...this.messages, msg]
    })

    this.connector.onStateChange((state: ConnectionState) => {
      this.connectionState = state
    })

    this.connector.onError((error: string) => {
      hilog.error(DOMAIN, 'ChatViewModel', `连接错误: ${error}`)
    })
  }

  async connect(): Promise<void> {
    try {
      await this.connector.connect({ url: this.connectionUrl })
    } catch (e) {
      hilog.error(DOMAIN, 'ChatViewModel', `连接失败: ${JSON.stringify(e)}`)
    }
  }

  disconnect(): void {
    this.connector.disconnect()
  }

  async sendText(text: string): Promise<void> {
    if (text.trim().length === 0) {
      return
    }
    try {
      await this.connector.sendMessage(text)
    } catch (e) {
      hilog.error(DOMAIN, 'ChatViewModel', `发送失败: ${JSON.stringify(e)}`)
    }
  }

  async sendImage(imageUrl: string): Promise<void> {
    try {
      await this.connector.sendMessage('', imageUrl)
    } catch (e) {
      hilog.error(DOMAIN, 'ChatViewModel', `发送图片失败: ${JSON.stringify(e)}`)
    }
  }

  async saveConnectionUrl(url: string): Promise<void> {
    this.connectionUrl = url
    if (this.dataPreferences) {
      this.dataPreferences.putSync(KEY_CONNECTION_URL, url)
      this.dataPreferences.flush()
    }
  }

  clearMessages(): void {
    this.messages = []
  }
}
