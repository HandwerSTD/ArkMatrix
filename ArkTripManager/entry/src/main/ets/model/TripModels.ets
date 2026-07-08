@ObservedV2
export class PlanItem {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace type: string = ''
  @Trace location: string = ''
  @Trace note: string = ''

  toJSON(): Record<string, Object> {
    return { time: this.time, title: this.title, type: this.type, location: this.location, note: this.note }
  }

  static fromJSON(data: Record<string, Object>): PlanItem {
    let p: PlanItem = new PlanItem()
    if (data['time'] !== undefined) p.time = data['time'] as string
    if (data['title'] !== undefined) p.title = data['title'] as string
    if (data['type'] !== undefined) p.type = data['type'] as string
    if (data['location'] !== undefined) p.location = data['location'] as string
    if (data['note'] !== undefined) p.note = data['note'] as string
    return p
  }
}

@ObservedV2
export class DailyPlan {
  @Trace day: number = 0
  @Trace date: string = ''
  @Trace items: PlanItem[] = []

  toJSON(): Record<string, Object> {
    return {
      day: this.day,
      date: this.date,
      items: this.items.map((item: PlanItem) => item.toJSON())
    }
  }

  static fromJSON(data: Record<string, Object>): DailyPlan {
    let d: DailyPlan = new DailyPlan()
    if (data['day'] !== undefined) d.day = data['day'] as number
    if (data['date'] !== undefined) d.date = data['date'] as string
    if (data['items']) {
      let rawItems: Record<string, Object>[] = data['items'] as Record<string, Object>[]
      d.items = rawItems.map((ri: Record<string, Object>) => PlanItem.fromJSON(ri))
    }
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

  toJSON(): Record<string, Object> {
    return {
      id: this.id, title: this.title, destination: this.destination,
      startDate: this.startDate, endDate: this.endDate, cover: this.cover,
      status: this.status,
      dailyPlans: this.dailyPlans.map((dp: DailyPlan) => dp.toJSON())
    }
  }

  static fromJSON(data: Record<string, Object>): Trip {
    let t: Trip = new Trip()
    if (data['id'] !== undefined) t.id = data['id'] as string
    if (data['title'] !== undefined) t.title = data['title'] as string
    if (data['destination'] !== undefined) t.destination = data['destination'] as string
    if (data['startDate'] !== undefined) t.startDate = data['startDate'] as string
    if (data['endDate'] !== undefined) t.endDate = data['endDate'] as string
    if (data['cover'] !== undefined) t.cover = data['cover'] as string
    if (data['status'] !== undefined) t.status = data['status'] as string
    if (data['dailyPlans']) {
      let raw: Record<string, Object>[] = data['dailyPlans'] as Record<string, Object>[]
      t.dailyPlans = raw.map((rd: Record<string, Object>) => DailyPlan.fromJSON(rd))
    }
    return t
  }
}
