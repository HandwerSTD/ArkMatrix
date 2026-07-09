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
