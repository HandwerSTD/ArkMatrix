import { IMessageConnector, ConnectionState, ConnectConfig } from '../protocol/IMessageConnector'
import { Message, MessageRole } from '../protocol/Message'

const MOCK_IMAGES: string[] = [
  'https://picsum.photos/400/300?random=1',
  'https://picsum.photos/400/300?random=2',
  'https://picsum.photos/400/300?random=3'
]

export class MockConnector implements IMessageConnector {
  connectionState: ConnectionState = ConnectionState.Idle
  private messageCallbacks: Array<(msg: Message) => void> = []
  private stateCallbacks: Array<(state: ConnectionState) => void> = []
  private errorCallbacks: Array<(error: string) => void> = []
  private messageIndex: number = 0

  private mockReplies: string[] = [
    '你好！有什么可以帮你的？',
    '收到，让我想想…',
    '好的，我记下了',
    '这个问题挺有意思的',
    '你可以试试这个方案',
    '需要我再详细说明吗？',
    '这个功能还在开发中',
    '了解了，还有其他问题吗？'
  ]

  async connect(config: ConnectConfig): Promise<void> {
    this.setState(ConnectionState.Connecting)
    await this.delay(500)
    this.setState(ConnectionState.Connected)

    let welcome = Message.createSystem(`已连接到 ${config.url}`)
    this.notifyMessage(welcome)

    let greeting = Message.createText(
      MessageRole.Assistant,
      '你好！我是 OpenClaw Bot 🦞\n有什么可以帮你的？'
    )
    this.notifyMessage(greeting)
  }

  disconnect(): void {
    this.setState(ConnectionState.Disconnected)
  }

  async sendMessage(text: string, imageUrl?: string): Promise<void> {
    let userMsg = Message.createText(MessageRole.User, text)
    this.notifyMessage(userMsg)

    await this.delay(800 + Math.random() * 1200)

    let reply = Message.createText(
      MessageRole.Assistant,
      this.mockReplies[this.messageIndex % this.mockReplies.length]
    )
    this.messageIndex++
    this.notifyMessage(reply)

    if (this.messageIndex % 3 === 0) {
      await this.delay(300)
      let imgUrl = MOCK_IMAGES[this.messageIndex % MOCK_IMAGES.length]
      let imgMsg = Message.createImage(MessageRole.Assistant, imgUrl, '这是一张示例图片')
      this.notifyMessage(imgMsg)
    }
  }

  onMessage(callback: (msg: Message) => void): void {
    this.messageCallbacks.push(callback)
  }

  onStateChange(callback: (state: ConnectionState) => void): void {
    this.stateCallbacks.push(callback)
  }

  onError(callback: (error: string) => void): void {
    this.errorCallbacks.push(callback)
  }

  private notifyMessage(msg: Message): void {
    for (let cb of this.messageCallbacks) {
      cb(msg)
    }
  }

  private setState(state: ConnectionState): void {
    this.connectionState = state
    for (let cb of this.stateCallbacks) {
      cb(state)
    }
  }

  private delay(ms: number): Promise<void> {
    return new Promise<void>((resolve: () => void) => {
      setTimeout(resolve, ms)
    })
  }
}
