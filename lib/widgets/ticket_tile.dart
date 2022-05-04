import 'package:bus_driver/models/ticket.dart';
import 'package:flutter/material.dart';


class TicketTile extends StatelessWidget {
  final Ticket ticket;
  const TicketTile({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo redesign
    return ListTile(
      leading: Text("Booking date?"),
      title: Text("Ticket id"),
      subtitle: Text("Customer name"),
      trailing: Text("Status"),
    );
  }
}
