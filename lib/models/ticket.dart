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
  // final Bus bus;
  String tripId;
  double amountPaid;
  TicketStatus status;
  ///index for this ticket in the bus
  int bookingCount;
  final String userId;
  final DateTime dateBooked;
  final String transactionId;


  Ticket({
    required this.id,
    required this.paymentMethod,
    required this.tripId,
    required this.transactionId,
    required this.amountPaid,
    required this.status,
    required this.userId,
    required this.dateBooked,
    required this.bookingCount,
});

  factory Ticket.fromJson(Map<String,dynamic> map) => Ticket(
      id: map["id"],
      transactionId: map["transactionId"],
      userId: map["userId"],
      paymentMethod:map[" paymentMethod"],
      tripId: map["tripId"],
      // bus: Bus.fromJson(map["bus"]),
      amountPaid: map["amountPaid"],
      status: TicketStatus.values.firstWhere((element) => element.name == map["status"]),
      bookingCount: map["bookingCount"],
    dateBooked: DateTime.parse(map["dateBooked"])
  );

  Map<String,dynamic> toMap() => {
    "id" : id,
    "paymentMethod" : paymentMethod,
    // "bus" : bus.toJson(),
    "tripId" : tripId,
    "amountPaid" : amountPaid,
    "status": status.name,
    "bookingCount" : bookingCount,
    "dateBooked" : dateBooked.toIso8601String()
  };

}