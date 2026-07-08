import { Ticket, Trip } from '../model/HangLvTravelModels'

export class HangLvTravelMock {
  static searchTickets(from: string, to: string, date: string): Ticket[] {
    let tickets: Ticket[] = []
    let t1 = new Ticket()
    t1.id = 't001'; t1.type = '高铁'; t1.trainNo = 'G123'
    t1.departure = from ? `${from}南` : '北京南'; t1.arrival = to ? `${to}南` : '南京南'
    t1.departTime = '12:00'; t1.arriveTime = '15:20'
    t1.duration = '3h20min'; t1.price = 443.5
    t1.delay = ''; t1.isSubscribed = false; t1.isBooked = false
    tickets.push(t1)
    let t2 = new Ticket()
    t2.id = 't002'; t2.type = '高铁'; t2.trainNo = 'G141'
    t2.departure = from ? `${from}南` : '北京南'; t2.arrival = to ? `${to}南` : '南京南'
    t2.departTime = '14:30'; t2.arriveTime = '17:55'
    t2.duration = '3h25min'; t2.price = 419
    t2.delay = '晚点60分钟'; t2.isSubscribed = true; t2.isBooked = false
    tickets.push(t2)
    let t3 = new Ticket()
    t3.id = 't003'; t3.type = '高铁'; t3.trainNo = 'G15'
    t3.departure = from ? `${from}南` : '北京南'; t3.arrival = to ? `${to}南` : '南京南'
    t3.departTime = '09:00'; t3.arriveTime = '11:50'
    t3.duration = '2h50min'; t3.price = 533
    t3.delay = ''; t3.isSubscribed = false; t3.isBooked = true
    tickets.push(t3)
    let t4 = new Ticket()
    t4.id = 't004'; t4.type = '飞机'; t4.trainNo = 'MU5132'
    t4.departure = from ? `${from}大兴` : '北京大兴'; t4.arrival = to ? `${to}禄口` : '南京禄口'
    t4.departTime = '08:30'; t4.arriveTime = '10:30'
    t4.duration = '2h'; t4.price = 890
    t4.delay = ''; t4.isSubscribed = false; t4.isBooked = false
    tickets.push(t4)
    return tickets
  }

  static getMyTrips(): Trip[] {
    let trips: Trip[] = []
    let tr1 = new Trip()
    tr1.id = 'trip001'; tr1.ticketId = 't003'
    tr1.status = '已出行'; tr1.bookDate = '2025-06-10'
    tr1.passengers = ['小李']
    trips.push(tr1)
    let tr2 = new Trip()
    tr2.id = 'trip002'; tr2.ticketId = 't001'
    tr2.status = '已预订'; tr2.bookDate = '2025-07-14'
    tr2.passengers = ['小李', '老王']
    trips.push(tr2)
    return trips
  }

  static bookTicket(ticketId: string): Trip {
    let trip = new Trip()
    trip.id = 'trip_new_' + Date.now()
    trip.ticketId = ticketId
    trip.status = '已预订'
    trip.bookDate = '2025-07-09'
    trip.passengers = ['小李']
    return trip
  }
}
