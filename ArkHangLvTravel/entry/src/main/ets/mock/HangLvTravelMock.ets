import { Ticket, Trip, ITicketData, ITripData } from '../model/HangLvTravelModels'

const RAW_TRIPS: ITripData[] = [
  { id: 'trip001', ticketId: 't003', status: '已出行', bookDate: '2025-06-10', passengers: ['小李'] },
  { id: 'trip002', ticketId: 't001', status: '已预订', bookDate: '2025-07-14', passengers: ['小李', '老王'] }
]

export class HangLvTravelMock {
  static getRawTrips(): ITripData[] {
    return RAW_TRIPS
  }

  static searchTickets(from: string, to: string, date: string): Ticket[] {
    let fromSuffix: string = from ? `${from}南` : '北京南'
    let toSuffix: string = to ? `${to}南` : '南京南'
    let raw: ITicketData[] = [
      { id: 't001', type: '高铁', trainNo: 'G123', departure: fromSuffix, arrival: toSuffix, departTime: '12:00', arriveTime: '15:20', duration: '3h20min', price: 443.5, delay: '', isSubscribed: false, isBooked: false },
      { id: 't002', type: '高铁', trainNo: 'G141', departure: fromSuffix, arrival: toSuffix, departTime: '14:30', arriveTime: '17:55', duration: '3h25min', price: 419, delay: '晚点60分钟', isSubscribed: true, isBooked: false },
      { id: 't003', type: '高铁', trainNo: 'G15', departure: fromSuffix, arrival: toSuffix, departTime: '09:00', arriveTime: '11:50', duration: '2h50min', price: 533, delay: '', isSubscribed: false, isBooked: true },
      { id: 't004', type: '飞机', trainNo: 'MU5132', departure: from ? `${from}大兴` : '北京大兴', arrival: to ? `${to}禄口` : '南京禄口', departTime: '08:30', arriveTime: '10:30', duration: '2h', price: 890, delay: '', isSubscribed: false, isBooked: false }
    ]
    return raw.map((d: ITicketData) => Ticket.fromJSON(d))
  }

  static getMyTrips(): Trip[] {
    return RAW_TRIPS.map((d: ITripData) => Trip.fromJSON(d))
  }

  static bookTicket(ticketId: string): Trip {
    let data: ITripData = {
      id: 'trip_new_' + Date.now(),
      ticketId: ticketId,
      status: '已预订',
      bookDate: '2025-07-09',
      passengers: ['小李']
    }
    return Trip.fromJSON(data)
  }
}
