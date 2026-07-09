# Bot Chat Client 设计文档

## 概述

在 ArkYouLink 项目中实现一个 Bot 聊天客户端，UI 形态类似 Telegram Bot 对话窗。
用户侧是 HarmonyOS ArkUI V2 界面，对端是 AI agent。采用协议抽象 + mock 驱动 UI 的策略，
V1 支持文本和图片消息。

## 架构

```
┌─────────────────────────────────┐
│  UI Layer (ArkUI V2)            │
│  ChatPage / ChatList / Bubble   │
├─────────────────────────────────┤
│  ViewModel                      │
│  ChatViewModel (状态管理)        │
├─────────────────────────────────┤
│  Protocol Layer (抽象接口)       │
│  IMessageConnector              │
├─────────────────────────────────┤
│  Connector Impl                 │
│  MockConnector / WsConnector    │
└─────────────────────────────────┘
```

数据流：`Connector → Message → ViewModel → @Trace → UI`，用户输入反向传递。

## 目录结构

```
entry/src/main/ets/
├── protocol/
│   ├── Message.ets
│   ├── IMessageConnector.ets
│   └── index.ets
├── connector/
│   ├── MockConnector.ets
│   └── index.ets
├── viewmodel/
│   └── ChatViewModel.ets
├── view/
│   ├── ChatBubble.ets
│   ├── ChatInput.ets
│   └── ChatList.ets
└── pages/
    ├── ChatPage.ets
    └── ConnectionSettingsPage.ets
```

## 协议层

### Message 模型

`@ObservedV2` class，单一类型，`contentType` 区分消息形态：

| 字段 | 类型 | 说明 |
|------|------|------|
| id | string | 唯一标识 |
| timestamp | number | Unix 毫秒 |
| role | Role | user / assistant / system |
| contentType | ContentType | text / image |
| text | string | 文本内容或图片附言 |
| imageUrl | string | 图片地址 |
| imageThumbnail | string | 缩略图 |
| status | MessageStatus | sending / sent / error |

### IMessageConnector

```
connect(config): Promise<void>
disconnect(): void
sendMessage(text, imageUrl?): Promise<void>
onMessage(cb): void
onStateChange(cb): void
onError(cb): void
connectionState: ConnectionState
```

## Mock 实现

MockConnector 实现 IMessageConnector：
- connect() 后发送系统欢迎消息，状态变为 connected
- 收到用户消息后延时 1-2s 返回 mock 助理回复，穿插图片消息
- 支持通过 `mockResponses` 数组配置回复序列

## 线协议设计（后续 WsConnector 使用）

JSON-over-WebSocket，参考 OpenClaw 模式：

```
客户端 → 服务端：
  {type:"req", id, method, params}

服务端 → 客户端：
  {type:"res", id, ok, payload}
  {type:"event", event, payload}
```

## UI 组件

- **ChatPage** — @Entry 页面，组装列表 + 输入框
- **ChatList** — ForEach 渲染消息，role=user 右侧/bot 左侧对齐
- **ChatBubble** — contentType=text 文本气泡，=image 图片卡片，含发送状态
- **ChatInput** — TextInput + 发送按钮，预留图片选择入口
- **ConnectionSettingsPage** — 连接配置页，输入 WebSocket 地址（ws://host:port），保存后用于 ChatViewModel.connect()

## 状态管理

ChatViewModel 持有 IMessageConnector 和 messages 数组（@Trace），暴露：
- `messages`: Message[]
- `connectionUrl`: string（由 ConnectionSettingsPage 持久化配置）
- `sendText(text)`
- `sendImage(url)`
- `connect() / disconnect()`（使用 connectionUrl 连接）

## V1 范围

- [x] 消息模型定义
- [x] 连接器接口抽象
- [x] Mock 连接器
- [x] ChatViewModel
- [x] 文本消息气泡
- [x] 图片消息气泡
- [x] 输入区域
- [x] ChatPage 页面组装
- [x] ConnectionSettingsPage 连接配置页
- [ ] 无流式输出
- [ ] 无工具调用展示
