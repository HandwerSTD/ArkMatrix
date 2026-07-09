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
