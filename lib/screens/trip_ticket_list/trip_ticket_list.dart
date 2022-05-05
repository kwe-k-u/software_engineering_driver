import 'package:vroom_core/models/ticket.dart';
import 'package:vroom_core/utils/firestore_helper.dart';
import 'package:bus_driver/widgets/ticket_tile.dart';
import 'package:flutter/material.dart';

class TripTicketList extends StatefulWidget {
  final String tripId;
  const TripTicketList({
    Key? key,
    required this.tripId
  }) : super(key: key);

  @override
  _TripTicketListState createState() => _TripTicketListState();
}

class _TripTicketListState extends State<TripTicketList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket List for ${widget.tripId}"),
      ),
        body: FutureBuilder<List<Ticket>>(
          future: getTripTickets(widget.tripId),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context,index)=> TicketTile(ticket : snapshot.data![index])
              );
              } else {
                return const Center(child: Text("No Tickets for this trip"),);
              }
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        )
    );
  }
}
