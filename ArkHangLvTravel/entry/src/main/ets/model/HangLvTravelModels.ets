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

  toJSON(): Record<string, Object> {
    return {
      id: this.id, type: this.type, trainNo: this.trainNo,
      departure: this.departure, arrival: this.arrival,
      departTime: this.departTime, arriveTime: this.arriveTime,
      duration: this.duration, price: this.price, delay: this.delay,
      isSubscribed: this.isSubscribed, isBooked: this.isBooked
    }
  }

  static fromJSON(data: Record<string, Object>): Ticket {
    let t: Ticket = new Ticket()
    if (data['id'] !== undefined) t.id = data['id'] as string
    if (data['type'] !== undefined) t.type = data['type'] as string
    if (data['trainNo'] !== undefined) t.trainNo = data['trainNo'] as string
    if (data['departure'] !== undefined) t.departure = data['departure'] as string
    if (data['arrival'] !== undefined) t.arrival = data['arrival'] as string
    if (data['departTime'] !== undefined) t.departTime = data['departTime'] as string
    if (data['arriveTime'] !== undefined) t.arriveTime = data['arriveTime'] as string
    if (data['duration'] !== undefined) t.duration = data['duration'] as string
    if (data['price'] !== undefined) t.price = data['price'] as number
    if (data['delay'] !== undefined) t.delay = data['delay'] as string
    if (data['isSubscribed'] !== undefined) t.isSubscribed = data['isSubscribed'] as boolean
    if (data['isBooked'] !== undefined) t.isBooked = data['isBooked'] as boolean
    return t
  }
}

@ObservedV2
export class Trip {
  @Trace id: string = ''
  @Trace ticketId: string = ''
  @Trace status: string = ''
  @Trace bookDate: string = ''
  @Trace passengers: string[] = []

  toJSON(): Record<string, Object> {
    return {
      id: this.id, ticketId: this.ticketId, status: this.status,
      bookDate: this.bookDate, passengers: this.passengers
    }
  }

  static fromJSON(data: Record<string, Object>): Trip {
    let t: Trip = new Trip()
    if (data['id'] !== undefined) t.id = data['id'] as string
    if (data['ticketId'] !== undefined) t.ticketId = data['ticketId'] as string
    if (data['status'] !== undefined) t.status = data['status'] as string
    if (data['bookDate'] !== undefined) t.bookDate = data['bookDate'] as string
    if (data['passengers'] !== undefined) t.passengers = data['passengers'] as string[]
    return t
  }
}
