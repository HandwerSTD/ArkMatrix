@ObservedV2
export class Ticket {
  @Trace id: string = ''
  @Trace type: string = ''
  @Trace trainNo: string = ''
  @Trace departure: string = ''
  @Trace arrival: string = ''
  @Trace departTime: string = ''
  @Trace arriveTime: string = ''
  @Trace duration: string = ''
  @Trace price: number = 0
  @Trace delay: string = ''
  @Trace isSubscribed: boolean = false
  @Trace isBooked: boolean = false
}

@ObservedV2
export class Trip {
  @Trace id: string = ''
  @Trace ticketId: string = ''
  @Trace status: string = ''
  @Trace bookDate: string = ''
  @Trace passengers: string[] = []
}
