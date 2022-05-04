import 'package:bus_driver/models/bus.dart';

enum TicketStatus{
  active,
  used,
  expired,
  revoked
}
class Ticket{
  final String id;
  final String paymentMethod; //todo change to enum
  final Bus bus;
  double amountPaid;
  TicketStatus status;
  int bookingCount;
  final String userId;
  final DateTime dateBooked;
//todo transaction id


  Ticket({
    required this.id,
    required this.paymentMethod,
    required this.bus,
    required this.amountPaid,
    required this.status,
    required this.userId,
    required this.dateBooked,
    required this.bookingCount,
});

  factory Ticket.fromJson(Map<String,dynamic> map) => Ticket(
      id: map["id"],
      userId: map["userId"],
      paymentMethod:map[" paymentMethod"],
      bus: Bus.fromJson(map["bus"]),
      amountPaid: map["amountPaid"],
      status: TicketStatus.values.firstWhere((element) => element.name == map["status"]),
      bookingCount: map["bookingCount"],
    dateBooked: DateTime.parse(map["dateBooked"])
  );

  Map<String,dynamic> toMap() => {
    "id" : id,
    "paymentMethod" : paymentMethod,
    "bus" : bus.toJson(),
    "amountPaid" : amountPaid,
    "status": status.name,
    "bookingCount" : bookingCount,
    "dateBooked" : dateBooked.toIso8601String()
  };

}