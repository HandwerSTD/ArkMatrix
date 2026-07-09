export interface ITicketData {
  id: string
  type: string
  trainNo: string
  departure: string
  arrival: string
  departTime: string
  arriveTime: string
  duration: string
  price: number
  delay: string
  isSubscribed: boolean
  isBooked: boolean
}

export interface ITripData {
  id: string
  ticketId: string
  status: string
  bookDate: string
  passengers: string[]
}

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

  toJSON(): ITicketData {
    return {
      id: this.id, type: this.type, trainNo: this.trainNo,
      departure: this.departure, arrival: this.arrival,
      departTime: this.departTime, arriveTime: this.arriveTime,
      duration: this.duration, price: this.price, delay: this.delay,
      isSubscribed: this.isSubscribed, isBooked: this.isBooked
    }
  }

  static fromJSON(data: ITicketData): Ticket {
    let t: Ticket = new Ticket()
    t.id = data.id; t.type = data.type; t.trainNo = data.trainNo
    t.departure = data.departure; t.arrival = data.arrival
    t.departTime = data.departTime; t.arriveTime = data.arriveTime
    t.duration = data.duration; t.price = data.price; t.delay = data.delay
    t.isSubscribed = data.isSubscribed; t.isBooked = data.isBooked
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

  toJSON(): ITripData {
    return {
      id: this.id, ticketId: this.ticketId, status: this.status,
      bookDate: this.bookDate, passengers: this.passengers
    }
  }

  static fromJSON(data: ITripData): Trip {
    let t: Trip = new Trip()
    t.id = data.id; t.ticketId = data.ticketId; t.status = data.status
    t.bookDate = data.bookDate; t.passengers = data.passengers
    return t
  }
}
