export interface IPlanItemData {
  time: string
  title: string
  type: string
  location: string
  note: string
}

export interface IDailyPlanData {
  day: number
  date: string
  items: IPlanItemData[]
}

export interface ITripData {
  id: string
  title: string
  destination: string
  startDate: string
  endDate: string
  cover: string
  status: string
  dailyPlans: IDailyPlanData[]
}

@ObservedV2
export class PlanItem {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace type: string = ''
  @Trace location: string = ''
  @Trace note: string = ''

  toJSON(): IPlanItemData {
    return { time: this.time, title: this.title, type: this.type, location: this.location, note: this.note }
  }

  static fromJSON(data: IPlanItemData): PlanItem {
    let p: PlanItem = new PlanItem()
    p.time = data.time; p.title = data.title; p.type = data.type; p.location = data.location; p.note = data.note
    return p
  }
}

@ObservedV2
export class DailyPlan {
  @Trace day: number = 0
  @Trace date: string = ''
  @Trace items: PlanItem[] = []

  toJSON(): IDailyPlanData {
    return {
      day: this.day,
      date: this.date,
      items: this.items.map((item: PlanItem) => item.toJSON())
    }
  }

  static fromJSON(data: IDailyPlanData): DailyPlan {
    let d: DailyPlan = new DailyPlan()
    d.day = data.day; d.date = data.date
    d.items = data.items.map((ri: IPlanItemData) => PlanItem.fromJSON(ri))
    return d
  }
}

@ObservedV2
export class Trip {
  @Trace id: string = ''
  @Trace title: string = ''
  @Trace destination: string = ''
  @Trace startDate: string = ''
  @Trace endDate: string = ''
  @Trace cover: string = ''
  @Trace status: string = ''
  @Trace dailyPlans: DailyPlan[] = []

  toJSON(): ITripData {
    return {
      id: this.id, title: this.title, destination: this.destination,
      startDate: this.startDate, endDate: this.endDate, cover: this.cover,
      status: this.status,
      dailyPlans: this.dailyPlans.map((dp: DailyPlan) => dp.toJSON())
    }
  }

  static fromJSON(data: ITripData): Trip {
    let t: Trip = new Trip()
    t.id = data.id; t.title = data.title; t.destination = data.destination
    t.startDate = data.startDate; t.endDate = data.endDate; t.cover = data.cover
    t.status = data.status
    t.dailyPlans = data.dailyPlans.map((rd: IDailyPlanData) => DailyPlan.fromJSON(rd))
    return t
  }
}
