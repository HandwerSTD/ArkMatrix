# Bot Chat Client Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a bot chat UI on HarmonyOS ArkUI V2 with protocol abstraction, mock connector, and connection settings page.

**Architecture:** Four-layer architecture — Protocol (Message model + IMessageConnector interface), Connector (MockConnector implementation), ViewModel (ChatViewModel state management), UI (ChatPage/ChatBubble/ChatInput/ChatList/ConnectionSettingsPage).

**Tech Stack:** HarmonyOS ArkTS, ArkUI V2, `@ObservedV2`/`@Trace` state management, `@kit.ArkUI` (router, promptAction), `@kit.ArkData` (preferences), `@kit.PerformanceAnalysisKit` (hilog).

---

### Task 1: Message Model

**Files:**
- Create: `entry/src/main/ets/protocol/Message.ets`

- [ ] **Step 1: Create Message model**

```typescript
export enum MessageRole {
  User = 'user',
  Assistant = 'assistant',
  System = 'system'
}

export enum ContentType {
  Text = 'text',
  Image = 'image'
}

export enum MessageStatus {
  Sending = 'sending',
  Sent = 'sent',
  Error = 'error'
}

export interface IMessageData {
  id: string
  timestamp: number
  role: string
  contentType: string
  text: string
  imageUrl: string
  imageThumbnail: string
  status: string
}

@ObservedV2
export class Message {
  @Trace id: string = ''
  @Trace timestamp: number = 0
  @Trace role: MessageRole = MessageRole.User
  @Trace contentType: ContentType = ContentType.Text
  @Trace text: string = ''
  @Trace imageUrl: string = ''
  @Trace imageThumbnail: string = ''
  @Trace status: MessageStatus = MessageStatus.Sending

  get isUser(): boolean { return this.role === MessageRole.User }
  get isAssistant(): boolean { return this.role === MessageRole.Assistant }
  get isSystem(): boolean { return this.role === MessageRole.System }
  get isText(): boolean { return this.contentType === ContentType.Text }
  get isImage(): boolean { return this.contentType === ContentType.Image }

  toJSON(): IMessageData {
    return {
      id: this.id,
      timestamp: this.timestamp,
      role: this.role,
      contentType: this.contentType,
      text: this.text,
      imageUrl: this.imageUrl,
      imageThumbnail: this.imageThumbnail,
      status: this.status
    }
  }

  static fromJSON(data: IMessageData): Message {
    let m = new Message()
    m.id = data.id
    m.timestamp = data.timestamp
    m.role = data.role as MessageRole
    m.contentType = data.contentType as ContentType
    m.text = data.text
    m.imageUrl = data.imageUrl
    m.imageThumbnail = data.imageThumbnail
    m.status = data.status as MessageStatus
    return m
  }

  static createText(role: MessageRole, text: string): Message {
    let m = new Message()
    m.id = `msg_${Date.now()}_${Math.floor(Math.random() * 10000)}`
    m.timestamp = Date.now()
    m.role = role
    m.contentType = ContentType.Text
    m.text = text
    m.status = MessageStatus.Sent
    return m
  }

  static createImage(role: MessageRole, imageUrl: string, text?: string): Message {
    let m = new Message()
    m.id = `msg_${Date.now()}_${Math.floor(Math.random() * 10000)}`
    m.timestamp = Date.now()
    m.role = role
    m.contentType = ContentType.Image
    m.imageUrl = imageUrl
    m.text = text ?? ''
    m.status = MessageStatus.Sent
    return m
  }

  static createSystem(text: string): Message {
    let m = new Message()
    m.id = `sys_${Date.now()}_${Math.floor(Math.random() * 10000)}`
    m.timestamp = Date.now()
    m.role = MessageRole.System
    m.contentType = ContentType.Text
    m.text = text
    m.status = MessageStatus.Sent
    return m
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/protocol/Message.ets
git commit -m "feat: add Message model with text/image support"
```

---

### Task 2: IMessageConnector Interface

**Files:**
- Create: `entry/src/main/ets/protocol/IMessageConnector.ets`

- [ ] **Step 1: Create connector interface**

```typescript
import { Message } from './Message'

export enum ConnectionState {
  Idle = 'idle',
  Connecting = 'connecting',
  Connected = 'connected',
  Disconnected = 'disconnected'
}

export interface ConnectConfig {
  url: string
  token?: string
}

export interface IMessageConnector {
  readonly connectionState: ConnectionState

  connect(config: ConnectConfig): Promise<void>
  disconnect(): void
  sendMessage(text: string, imageUrl?: string): Promise<void>

  onMessage(callback: (msg: Message) => void): void
  onStateChange(callback: (state: ConnectionState) => void): void
  onError(callback: (error: string) => void): void
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/protocol/IMessageConnector.ets
git commit -m "feat: add IMessageConnector interface"
```

---

### Task 3: Protocol Barrel Export

**Files:**
- Create: `entry/src/main/ets/protocol/index.ets`

- [ ] **Step 1: Create barrel export**

```typescript
export { Message, MessageRole, ContentType, MessageStatus } from './Message'
export { IMessageConnector, ConnectionState, ConnectConfig } from './IMessageConnector'
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/protocol/index.ets
git commit -m "feat: add protocol barrel export"
```

---

### Task 4: MockConnector

**Files:**
- Create: `entry/src/main/ets/connector/MockConnector.ets`

- [ ] **Step 1: Create MockConnector**

```typescript
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
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/connector/MockConnector.ets
git commit -m "feat: add MockConnector implementation"
```

---

### Task 5: Connector Barrel Export

**Files:**
- Create: `entry/src/main/ets/connector/index.ets`

- [ ] **Step 1: Create barrel export**

```typescript
export { MockConnector } from './MockConnector'
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/connector/index.ets
git commit -m "feat: add connector barrel export"
```

---

### Task 6: ChatViewModel

**Files:**
- Create: `entry/src/main/ets/viewmodel/ChatViewModel.ets`

- [ ] **Step 1: Create ChatViewModel**

```typescript
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
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/viewmodel/ChatViewModel.ets
git commit -m "feat: add ChatViewModel with persistent connection config"
```

---

### Task 7: ChatBubble

**Files:**
- Create: `entry/src/main/ets/view/ChatBubble.ets`

- [ ] **Step 1: Create ChatBubble component**

```typescript
import { Message, MessageStatus } from '../protocol/Message'

@ComponentV2
export struct ChatBubble {
  @Param message: Message = new Message()

  build() {
    Row() {
      if (this.message.isAssistant || this.message.isSystem) {
        this.buildAvatar()
        this.buildContent()
        Blank()
      } else {
        Blank()
        this.buildContent()
        this.buildAvatar()
      }
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    .justifyContent(this.message.isUser ? FlexAlign.End : FlexAlign.Start)
  }

  @Builder
  buildAvatar() {
    Text(this.message.isUser ? '👤' : (this.message.isSystem ? '⚙️' : '🦞'))
      .fontSize(28)
      .margin(this.message.isUser ? { left: 8 } : { right: 8 })
  }

  @Builder
  buildContent() {
    Column() {
      if (this.message.isText) {
        Text(this.message.text)
          .fontSize(14)
          .fontColor(this.message.isUser ? Color.White : '#333')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.message.isUser ? '#FF6600' : (this.message.isSystem ? '#F0F0F0' : '#FFFFFF'))
          .borderRadius(12)
          .constraintSize({ maxWidth: '75%' })
      } else if (this.message.isImage) {
        Column() {
          if (this.message.text.length > 0) {
            Text(this.message.text)
              .fontSize(12)
              .fontColor('#999')
              .margin({ bottom: 6 })
          }
          Image(this.message.imageUrl)
            .width(200)
            .height(150)
            .borderRadius(8)
            .objectFit(ImageFit.Cover)
            .backgroundColor('#F0F0F0')
        }
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor(this.message.isUser ? '#FF6600' : '#FFFFFF')
        .borderRadius(12)
        .constraintSize({ maxWidth: '75%' })
      }

      if (this.message.isUser && this.message.status === MessageStatus.Error) {
        Text('发送失败')
          .fontSize(10)
          .fontColor('#FF3B30')
          .margin({ top: 2 })
      }
    }
    .alignItems(this.message.isUser ? HorizontalAlign.End : HorizontalAlign.Start)
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/view/ChatBubble.ets
git commit -m "feat: add ChatBubble component"
```

---

### Task 8: ChatInput

**Files:**
- Create: `entry/src/main/ets/view/ChatInput.ets`

- [ ] **Step 1: Create ChatInput component**

```typescript
import { ConnectionState } from '../protocol/IMessageConnector'

@ComponentV2
export struct ChatInput {
  @Param disabled: boolean = false
  @Event onSend: (text: string) => void = (text: string) => {}
  @Event onSettingsClick: () => void = () => {}
  @Local inputText: string = ''

  build() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(28)
        .height(28)
        .borderRadius(14)
        .margin({ right: 8 })
        .onClick(() => {
          this.onSettingsClick()
        })

      TextInput({ placeholder: '输入消息...', text: this.inputText })
        .fontSize(14)
        .layoutWeight(1)
        .height(36)
        .backgroundColor('#F5F5F5')
        .borderRadius(18)
        .padding({ left: 14, right: 14 })
        .enabled(!this.disabled)
        .onChange((value: string) => {
          this.inputText = value
        })

      Button('发送')
        .fontSize(13)
        .height(34)
        .padding({ left: 14, right: 14 })
        .backgroundColor('#FF6600')
        .borderRadius(17)
        .margin({ left: 8 })
        .enabled(this.inputText.trim().length > 0 && !this.disabled)
        .onClick(() => {
          let text = this.inputText.trim()
          if (text.length > 0) {
            this.onSend(text)
            this.inputText = ''
          }
        })
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/view/ChatInput.ets
git commit -m "feat: add ChatInput component"
```

---

### Task 9: ChatList

**Files:**
- Create: `entry/src/main/ets/view/ChatList.ets`

- [ ] **Step 1: Create ChatList component**

```typescript
import { Message } from '../protocol/Message'
import { ChatBubble } from './ChatBubble'

@ComponentV2
export struct ChatList {
  @Param messages: Message[] = []

  build() {
    List({ scroller: this.scroller }) {
      ForEach(this.messages, (msg: Message, index: number) => {
        ListItem() {
          ChatBubble({ message: msg })
        }
      }, (msg: Message) => msg.id)
    }
    .layoutWeight(1)
    .width('100%')
    .backgroundColor('#F8F8F8')
    .onAppear(() => {
      let count = this.messages.length
      if (count > 0) {
        this.scroller.scrollToIndex(count - 1, false)
      }
    })
  }

  private scroller: Scroller = new Scroller()
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/view/ChatList.ets
git commit -m "feat: add ChatList component"
```

---

### Task 10: ChatPage

**Files:**
- Create: `entry/src/main/ets/pages/ChatPage.ets`

- [ ] **Step 1: Create ChatPage**

```typescript
import { ChatList } from '../view/ChatList'
import { ChatInput } from '../view/ChatInput'
import { ChatViewModel } from '../viewmodel/ChatViewModel'
import { ConnectionState } from '../protocol/IMessageConnector'
import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct ChatPage {
  @Local viewModel: ChatViewModel = new ChatViewModel()
  @Local isConnected: boolean = false

  aboutToAppear(): void {
    this.viewModel.init().then(() => {
      this.viewModel.connect()
    })
  }

  aboutToDisappear(): void {
    this.viewModel.disconnect()
  }

  build() {
    Column() {
      Row() {
        Text('🦞 OpenClaw Bot')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Text(this.statusText())
          .fontSize(11)
          .fontColor(this.isConnected ? '#34C759' : '#999')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      .border({ width: { bottom: 0.5 }, color: '#E5E5E5' })

      if (this.viewModel.messages.length === 0 && this.isConnected) {
        Column() {
          Text('🦞')
            .fontSize(48)
            .margin({ bottom: 12 })
          Text('开始和 Bot 对话吧')
            .fontSize(14)
            .fontColor('#999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else {
        ChatList({ messages: this.viewModel.messages })
      }

      ChatInput({
        disabled: !this.isConnected,
        onSend: (text: string) => {
          this.viewModel.sendText(text)
        },
        onSettingsClick: () => {
          router.pushUrl({ url: 'pages/ConnectionSettingsPage' })
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
    .onDidBuild(() => {
      this.isConnected = this.viewModel.connectionState === ConnectionState.Connected
    })
  }

  private statusText(): string {
    switch (this.viewModel.connectionState) {
      case ConnectionState.Connected:
        return '已连接'
      case ConnectionState.Connecting:
        return '连接中…'
      case ConnectionState.Disconnected:
        return '已断开'
      default:
        return '未连接'
    }
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/pages/ChatPage.ets
git commit -m "feat: add ChatPage"
```

---

### Task 11: ConnectionSettingsPage

**Files:**
- Create: `entry/src/main/ets/pages/ConnectionSettingsPage.ets`

- [ ] **Step 1: Create ConnectionSettingsPage**

```typescript
import { preferences } from '@kit.ArkData'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct ConnectionSettingsPage {
  @Local url: string = 'ws://localhost:18789'
  @Local savedUrl: string = ''

  aboutToAppear(): void {
    let prefs = preferences.getPreferencesSync(getContext(), { name: 'chat_settings' })
    this.savedUrl = prefs.getSync('connection_url', 'ws://localhost:18789') as string
    this.url = this.savedUrl
  }

  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .margin({ right: 8 })
          .onClick(() => {
            router.back()
          })
        Text('连接设置')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)

      Column() {
        Text('WebSocket 地址')
          .fontSize(12)
          .fontColor('#999')
          .width('100%')
          .margin({ bottom: 8 })

        TextInput({ placeholder: 'ws://host:port', text: this.url })
          .fontSize(14)
          .width('100%')
          .height(44)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .padding({ left: 12, right: 12 })
          .onChange((value: string) => {
            this.url = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ left: 12, right: 12, top: 12 })

      Button('保存连接')
        .fontSize(14)
        .width('100%')
        .height(44)
        .backgroundColor('#FF6600')
        .borderRadius(22)
        .margin({ left: 12, right: 12, top: 24 })
        .onClick(() => {
          let prefs = preferences.getPreferencesSync(getContext(), { name: 'chat_settings' })
          prefs.putSync('connection_url', this.url.trim())
          prefs.flush()
          this.savedUrl = this.url.trim()
          promptAction.showToast({ message: '已保存，请返回聊天页重新连接' })
        })

      if (this.savedUrl.length > 0) {
        Text(`当前地址：${this.savedUrl}`)
          .fontSize(12)
          .fontColor('#999')
          .margin({ top: 12 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/pages/ConnectionSettingsPage.ets
git commit -m "feat: add ConnectionSettingsPage"
```

---

### Task 12: Register Pages and Navigation

**Files:**
- Modify: `entry/src/main/resources/base/profile/main_pages.json`
- Modify: `entry/src/main/ets/pages/Index.ets`

- [ ] **Step 1: Register pages in main_pages.json**

Change:
```json
{
  "src": [
    "pages/Index",
    "pages/LeaveStatus"
  ]
}
```
To:
```json
{
  "src": [
    "pages/Index",
    "pages/LeaveStatus",
    "pages/ChatPage",
    "pages/ConnectionSettingsPage"
  ]
}
```

- [ ] **Step 2: Add ChatPage navigation to Index**

In `Index.ets`, add import at top, and add an entry point. Add import after existing imports:

```typescript
// Add this import at top (after existing imports)
// No import needed, router is already imported
```

Replace the `QuickActions` section in `build()` (lines 57-61) by adding a chat entry to the actions. Since QuickActions is a separate component with hardcoded actions, add a button alongside it.

Modify the `build()` method — after the `QuickActions` block, add:

```typescript
Row() {
  Text('💬')
    .fontSize(20)
    .margin({ right: 8 })
  Text('Bot 对话')
    .fontSize(14)
    .fontWeight(FontWeight.Medium)
    .layoutWeight(1)
  Image($r('sys.media.ohos_ic_public_arrow_right'))
    .width(16)
    .height(16)
    .fillColor('#CCC')
}
.width('100%')
.padding(14)
.backgroundColor(Color.White)
.margin({ left: 12, right: 12, top: 8 })
.borderRadius(8)
.onClick(() => {
  router.pushUrl({ url: 'pages/ChatPage' })
})
```

- [ ] **Step 3: Commit**

```bash
git add entry/src/main/resources/base/profile/main_pages.json entry/src/main/ets/pages/Index.ets
git commit -m "feat: register ChatPage and ConnectionSettingsPage, add nav from Index"
```

---

### Task 13: Fix ChatPage ConnectionState Reactivity

**Files:**
- Modify: `entry/src/main/ets/pages/ChatPage.ets`

- [ ] **Step 1: Remove @Local isConnected, use viewModel directly in build()**

Remove `@Local isConnected: boolean = false` declaration:

```
// DELETE:
@Local isConnected: boolean = false
```

In `build()`, replace all `this.isConnected` with `this.viewModel.connectionState === ConnectionState.Connected`.

Remove the `.onDidBuild(...)` block entirely:

```
// DELETE:
.onDidBuild(() => {
  this.isConnected = this.viewModel.connectionState === ConnectionState.Connected
})
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/pages/ChatPage.ets
git commit -m "fix: simplify connection state reactivity"
```

---

### Task 14: Add ChatInput scroll-to-bottom on new messages

**Files:**
- Modify: `entry/src/main/ets/view/ChatList.ets`

- [ ] **Step 1: Expose scroll-to-bottom method**

Replace the ChatList content with version that auto-scrolls when messages change:

```typescript
import { Message } from '../protocol/Message'
import { ChatBubble } from './ChatBubble'

@ComponentV2
export struct ChatList {
  @Param messages: Message[] = []
  private scroller: Scroller = new Scroller()

  build() {
    List({ scroller: this.scroller }) {
      ForEach(this.messages, (msg: Message) => {
        ListItem() {
          ChatBubble({ message: msg })
        }
      }, (msg: Message) => msg.id)
    }
    .layoutWeight(1)
    .width('100%')
    .backgroundColor('#F8F8F8')
  }

  @Monitor('messages.length')
  onMessagesChanged() {
    let count = this.messages.length
    if (count > 0) {
      this.scroller.scrollToIndex(count - 1, false)
    }
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add entry/src/main/ets/view/ChatList.ets
git commit -m "fix: auto-scroll to bottom on new messages via @Monitor"
```

---

### Task 15: Verify Build

- [ ] **Step 1: Check TypeScript compilation**

```bash
node --version
```

Expected: Node.js is available. Since DevEco Studio handles the build, verify manually that:
- All files exist at the correct paths
- `main_pages.json` contains 4 entries
- `Index.ets` has the navigation link to ChatPage

- [ ] **Step 2: List all created files**

```bash
Get-ChildItem -Recurse -Path "entry/src/main/ets" -Include "*.ets" | Select-Object FullName
```

Expected output includes all new files:
- protocol/Message.ets
- protocol/IMessageConnector.ets
- protocol/index.ets
- connector/MockConnector.ets
- connector/index.ets
- viewmodel/ChatViewModel.ets
- view/ChatBubble.ets
- view/ChatInput.ets
- view/ChatList.ets
- pages/ChatPage.ets
- pages/ConnectionSettingsPage.ets
