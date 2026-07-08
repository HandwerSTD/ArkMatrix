@ObservedV2
export class PlanItem {
  @Trace time: string = ''
  @Trace title: string = ''
  @Trace type: string = ''
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
  @Trace status: string = ''
  @Trace dailyPlans: DailyPlan[] = []
}
