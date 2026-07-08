# ArkMatrix 实现计划（V2 状态管理）

> 基于 舟旅Agent.md 的生态矩阵，所有项目使用 HarmonyOS V2 状态管理（`@ObservedV2` / `@Trace` / `@Local` / `@Param` / `@Event` / `@ComponentV2`）。

---

## 通用架构

每个项目新增目录结构：

```
entry/src/main/ets/
├── model/          ← @ObservedV2 数据模型类 + @Trace 字段
├── mock/           ← 返回模型实例数组的 MockService（静态方法）
├── pages/          ← @Entry @ComponentV2 页面（@Local 管理页面状态）
└── view/           ← 子组件（@Param 接收数据，@Event 回传事件）
```

---

## 1. ArkDaDeMap（大德地图）

### model/DaDeMapModels.ets

```ts
@ObservedV2
export class POI {
  @Trace name: string = ''
  @Trace type: string = ''
  @Trace rating: number = 0
  @Trace distance: string = ''
  @Trace address: string = ''
  @Trace tags: string[] = []
  @Trace isCollected: boolean = false
}

@ObservedV2
export class Route {
  @Trace type: string = ''       // "驾车" / "公交" / "步行"
  @Trace duration: string = ''   // "45分钟"
  @Trace distance: string = ''   // "12km"
  @Trace traffic: string = ''    // "拥堵" / "畅通" / "缓行"
  @Trace steps: string[] = []
  @Trace hasDelay: boolean = false
}
```

### mock/DaDeMapMock.ets

```ts
export class DaDeMapMock {
  static getNearbyPOIs(): POI[] { /* 返回6条POI */ }
  static getRoutes(): Route[] { /* 返回3条路线 */ }
  static getNavigationSteps(): string[] { /* 返回导航步骤 */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local 搜索词/选中Tab/POI列表；顶部搜索栏 + 4个功能入口Row + 附近推荐List |
| `pages/RouteResult.ets` | @Entry @ComponentV2 | @Local routes列表；展示多条路线卡片 |
| `pages/Navigation.ets` | @Entry @ComponentV2 | @Local currentStep索引；展示导航步骤 + 路况标注 |
| `view/PoiCard.ets` | @ComponentV2 | @Param poi:POI, @Event onCollect:(id)=>void |
| `view/RouteCard.ets` | @ComponentV2 | @Param route:Route, @Event onSelect:(route)=>void |

---

## 2. ArkHuaBanMusic（花瓣音乐）

### model/HuaBanMusicModels.ets

```ts
@ObservedV2
export class Playlist {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace cover: string = ''
  @Trace songCount: number = 0
  @Trace description: string = ''
  @Trace songs: string[] = []
}

@ObservedV2
export class TravelRadio {
  @Trace destination: string = ''
  @Trace mood: string = ''
  @Trace songs: string[] = []
  @Trace isGenerated: boolean = false
}
```

### mock/HuaBanMusicMock.ets

```ts
export class HuaBanMusicMock {
  static getPlaylists(): Playlist[] { /* 4条歌单 */ }
  static generateRadio(dest: string): TravelRadio { /* 返回新电台 */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local playlists/expandedId；歌单列表 + 旅行电台入口banner |
| `pages/TravelRadio.ets` | @Entry @ComponentV2 | @Local destination/radio；目的地输入 + 生成按钮 + 电台展示 |
| `view/PlaylistCard.ets` | @ComponentV2 | @Param playlist:Playlist, @Event onExpand:(id)=>void |
| `view/RadioCard.ets` | @ComponentV2 | @Param radio:TravelRadio |

---

## 3. ArkXiaoZhongReview（小众点评）

### model/XiaoZhongReviewModels.ets

```ts
@ObservedV2
export class POI {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace category: string = ''
  @Trace rating: number = 0
  @Trace reviewCount: number = 0
  @Trace address: string = ''
  @Trace isCollected: boolean = false
  @Trace image: string = ''
}

@ObservedV2
export class Review {
  @Trace author: string = ''
  @Trace rating: number = 0
  @Trace content: string = ''
  @Trace date: string = ''
}

@ObservedV2
export class Collection {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace poiIds: string[] = []
}
```

### mock/XiaoZhongReviewMock.ets

```ts
export class XiaoZhongReviewMock {
  static searchPOI(query: string, category: string): POI[] { /* 过滤返回 */ }
  static getReviews(poiId: string): Review[] { /* 4条评价 */ }
  static getCollections(): Collection[] { /* 2个收藏夹 */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local searchQuery/categoryTab/poiList；搜索 + 分类Tab + POI流 |
| `pages/PoiDetail.ets` | @Entry @ComponentV2 | @Local poi/reviews/isCollected；详情 + 评论列表 + 收藏按钮 |
| `pages/PostReview.ets` | @Entry @ComponentV2 | @Local inputRating/inputContent；评分选择 + TextArea + 提交 |
| `view/PoiCard.ets` | @ComponentV2 | @Param poi:POI, @Event onClick:(id)=>void |
| `view/ReviewItem.ets` | @ComponentV2 | @Param review:Review |
| `view/CategoryTabs.ets` | @ComponentV2 | @Param tabs/selected, @Event onSelect:(index)=>void |
| `view/StarRating.ets` | @ComponentV2 | @Param rating/total, @Event onRate:(value)=>void |

---

## 4. ArkHangLvTravel（行旅纵横）

### model/HangLvTravelModels.ets

```ts
@ObservedV2
export class Ticket {
  @Trace id: string = ''
  @Trace type: string = ''         // "高铁" / "飞机"
  @Trace trainNo: string = ''      // "G123"
  @Trace departure: string = ''
  @Trace arrival: string = ''
  @Trace departTime: string = ''
  @Trace arriveTime: string = ''
  @Trace duration: string = ''
  @Trace price: number = 0
  @Trace delay: string = ''        // "晚点60分钟"
  @Trace isSubscribed: boolean = false
  @Trace isBooked: boolean = false
}

@ObservedV2
export class Trip {
  @Trace id: string = ''
  @Trace ticketId: string = ''
  @Trace status: string = ''       // "已预订" / "已出行" / "已取消"
  @Trace bookDate: string = ''
  @Trace passengers: string[] = []
}
```

### mock/HangLvTravelMock.ets

```ts
export class HangLvTravelMock {
  static searchTickets(from: string, to: string, date: string): Ticket[] { /* 4条车次 */ }
  static getMyTrips(): Trip[] { /* 2条行程 */ }
  static bookTicket(ticketId: string): Trip { /* 返回新Trip */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local from/to/date；搜索表单 + 快速入口 |
| `pages/SearchResult.ets` | @Entry @ComponentV2 | @Local tickets；车次列表 + 预订 + 延误订阅开关 |
| `pages/MyTrips.ets` | @Entry @ComponentV2 | @Local trips；行程列表 + 取消操作 |
| `view/TicketCard.ets` | @ComponentV2 | @Param ticket:Ticket, @Event onBook:(id)=>void, @Event onSubscribe:(id, bool)=>void |
| `view/TripCard.ets` | @ComponentV2 | @Param trip:Trip, @Event onCancel:(id)=>void |

---

## 5. ArkJuXinIM（巨信）

### model/JuXinIMModels.ets

```ts
@ObservedV2
export class Contact {
  @Trace id: string = ''
  @Trace name: string = ''
  @Trace avatar: string = ''
  @Trace status: string = ''          // "在线" / "离线" / "忙碌"
  @Trace recentMessage: string = ''
  @Trace recentTime: string = ''
}

@ObservedV2
export class Message {
  @Trace id: string = ''
  @Trace fromId: string = ''
  @Trace content: string = ''
  @Trace time: string = ''
  @Trace isMe: boolean = false
  @Trace isPlanCard: boolean = false
  @Trace planCard: PlanCardData | null = null
}

@ObservedV2
export class PlanCardData {
  @Trace title: string = ''
  @Trace date: string = ''
  @Trace destination: string = ''
  @Trace ticketInfo: string = ''
  @Trace poiCount: number = 0
}
```

### mock/JuXinIMMock.ets

```ts
export class JuXinIMMock {
  static getContacts(): Contact[] { /* 8条联系人 */ }
  static getMessages(contactId: string): Message[] { /* 6条消息含1张旅行卡片 */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local searchQuery/contacts；搜索 + 联系人列 |
| `pages/Chat.ets` | @Entry @ComponentV2 | @Local messages/inputText；消息列表 + 输入 + 分享菜单 |
| `view/ContactItem.ets` | @ComponentV2 | @Param contact:Contact, @Event onClick:(id)=>void |
| `view/MessageBubble.ets` | @ComponentV2 | @Param message:Message |
| `view/PlanCardShare.ets` | @ComponentV2 | @Param card:PlanCardData |
| `view/ShareMenu.ets` | @ComponentV2 | @Event onSharePlan:()=>void |

---

## 6. ArkYouLink

### model/YouLinkModels.ets

```ts
@ObservedV2
export class ScheduleEvent {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace location: string = ''
  @Trace isImportant: boolean = false
}

@ObservedV2
export class LeaveRecord {
  @Trace id: string = ''
  @Trace type: string = ''        // "年假" / "事假" / "病假"
  @Trace startDate: string = ''
  @Trace endDate: string = ''
  @Trace status: string = ''      // "已审批" / "审批中" / "已驳回"
  @Trace reason: string = ''
}

@ObservedV2
export class UserStatus {
  @Trace label: string = '在线'
  @Trace icon: string = '🟢'
}

@ObservedV2
export class AutoReplyRule {
  @Trace isEnabled: boolean = false
  @Trace presetMessage: string = ''
}
```

### mock/YouLinkMock.ets

```ts
export class YouLinkMock {
  static getTodaySchedule(): ScheduleEvent[] { /* 4条日程 */ }
  static getLeaveRecords(): LeaveRecord[] { /* 3条记录 */ }
  static submitLeave(type: string, reason: string): LeaveRecord { /* 返回新记录 */ }
  static getStatusOptions(): UserStatus[] { /* 3个选项 */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local schedule/currentStatus；状态卡片 + 日程List + 快捷操作 |
| `pages/LeaveStatus.ets` | @Entry @ComponentV2 | @Local records；请假记录列表 + 新建请假表单 |
| `view/ScheduleCard.ets` | @ComponentV2 | @Param event:ScheduleEvent |
| `view/StatusSelector.ets` | @ComponentV2 | @Param options/current, @Event onSelect:(status)=>void |
| `view/QuickActions.ets` | @ComponentV2 | @Event onLeave:()=>void, onAutoReply:()=>void, onUpdateStatus:()=>void |
| `view/LeaveRecordCard.ets` | @ComponentV2 | @Param record:LeaveRecord |
| `view/LeaveForm.ets` | @ComponentV2 | @Event onSubmit:(type, reason)=>void |

---

## 7. ArkNotes（备忘录）

### model/NoteModels.ets

```ts
@ObservedV2
export class ChecklistItem {
  @Trace text: string = ''
  @Trace isDone: boolean = false
}

@ObservedV2
export class Note {
  @Trace id: string = ''
  @Trace title: string = ''
  @Trace content: string = ''
  @Trace date: string = ''
  @Trace tags: string[] = []
  @Trace type: 'note' | 'checklist' = 'note'
  @Trace checklist: ChecklistItem[] = []
}
```

### mock/NotesMock.ets

```ts
export class NotesMock {
  static getNotes(): Note[] { /* 6条笔记含1条checklist */ }
  static createNote(data: Partial<Note>): Note { /* 返回新Note */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local notes/searchQuery/activeTab（笔记/清单）；列表 + 搜索 + FAB |
| `pages/NoteEdit.ets` | @Entry @ComponentV2 | @Local title/content/type/checklist；编辑 + 切换类型 + 保存 |
| `view/NoteCard.ets` | @ComponentV2 | @Param note:Note, @Event onClick:(id)=>void |
| `view/ChecklistCard.ets` | @ComponentV2 | @Param note:Note, @Event onToggle:(noteId, itemIdx)=>void |
| `view/ChecklistEditor.ets` | @ComponentV2 | @Local items:ChecklistItem[], @Event onAdd:(text)=>void, @Event onToggle:(idx)=>void |

---

## 8. ArkTripManager（方舟旅迹）

### model/TripModels.ets

```ts
@ObservedV2
export class PlanItem {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace type: string = ''       // "交通" / "美食" / "景点" / "购物"
  @Trace location: string = ''
  @Trace note: string = ''
}

@ObservedV2
export class DailyPlan {
  @Trace day: number = 0
  @Trace date: string = ''
  @Trace items: PlanItem[] = []
}

@ObservedV2
export class Trip {
  @Trace id: string = ''
  @Trace title: string = ''
  @Trace destination: string = ''
  @Trace startDate: string = ''
  @Trace endDate: string = ''
  @Trace cover: string = ''
  @Trace status: string = ''       // "待出发" / "进行中" / "已完成"
  @Trace dailyPlans: DailyPlan[] = []
}
```

### mock/TripManagerMock.ets

```ts
export class TripManagerMock {
  static getTrips(): Trip[] { /* 3条行程 */ }
  static createTrip(data: Partial<Trip>): Trip { /* 返回新Trip */ }
  static addPlanItem(tripId: string, day: number, item: PlanItem): void { /* 追加 */ }
}
```

### 页面 & 组件

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `pages/Index.ets` | @Entry @ComponentV2 | @Local trips；旅行计划列表 + 新建按钮 + 新建表单弹窗 |
| `pages/TripDetail.ets` | @Entry @ComponentV2 | @Local trip/selectedDay；每日行程Tab + PlanItem列表 + 添加/删除 |
| `view/TripCard.ets` | @ComponentV2 | @Param trip:Trip, @Event onClick:(id)=>void |
| `view/DayTabBar.ets` | @ComponentV2 | @Param days/selected, @Event onSelect:(day)=>void |
| `view/PlanItemCard.ets` | @ComponentV2 | @Param item:PlanItem, @Event onDelete:(itemIdx)=>void |
| `view/AddPlanForm.ets` | @ComponentV2 | @Event onSubmit:(item:PlanItem)=>void |

---

## 路由配置

每个项目修改 `entry/src/main/resources/base/profile/main_pages.json`：

```json
{
  "src": ["pages/Index", "pages/Page2", "pages/Page3"]
}
```

页面间通过 `router.pushUrl({ url: 'pages/XXX' })` 跳转。无额外依赖。

---

## V2 状态管理核心模式

| 场景 | 装饰器 | 说明 |
|------|--------|------|
| 数据模型类 | `@ObservedV2` + `@Trace` | 替代 `@Observed`，`@Trace` 标记响应式字段 |
| 页面自有状态 | `@Local` | 替代 `@State`，在 `@ComponentV2` 中使用 |
| 父传子（单向） | `@Param` | 替代 `@Prop`，只读数据注入 |
| 子传父（事件） | `@Event` | 替代回调函数传参 |
| 组件定义 | `@ComponentV2` | 替代 `@Component`，启用 V2 装饰器 |

所有项目遵循以上架构，模型与视图完全分离，Demo 数据由 MockService 提供纯前端硬编码数组，无外部依赖。
