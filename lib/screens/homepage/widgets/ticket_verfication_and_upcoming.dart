import 'package:bus_driver/models/app_state.dart';
import 'package:bus_driver/models/ticket.dart';
import 'package:bus_driver/models/trip.dart';
import 'package:bus_driver/utils/extensions.dart';
import 'package:bus_driver/utils/firestore_helper.dart';
import 'package:bus_driver/widgets/custom_button.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';



class TicketVerificationAndUpcoming extends StatefulWidget {
  const TicketVerificationAndUpcoming({Key? key}) : super(key: key);

  @override
  _TicketVerificationAndUpcomingState createState() => _TicketVerificationAndUpcomingState();
}

class _TicketVerificationAndUpcomingState extends State<TicketVerificationAndUpcoming> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(16),
      child: Expanded(
        child: Column(
          children: const [

            _CreditBalance(),
            _UnusedTickets()

          ],
        ),
      ),
    );
  }
}





class _CreditBalance extends StatelessWidget {
  const _CreditBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.zero,
      child:
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Ashesi Ticket Verification",
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                ],
              ),
              CustomButton(
                  text: "Scan receipt",
                  onPressed: ()async{

                  },
                radius: 6,
              )
            ],
      ),
        ),
    );
  }
}




class _UnusedTickets extends StatelessWidget {
  const _UnusedTickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Trip?>(
      future: getUpcomingTrip(context.read<AppState>().auth!.currentUser!.uid),
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data != null) {
          return Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            child:
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your next Trip",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle2,
                        ),
                        Text("20/${snapshot.data!.capacity} seats")
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: snapshot.data!.pickupLocation,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(text: " to ",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText2
                                    ),
                                    TextSpan(
                                        text: snapshot.data!.dropOffLocation
                                    ),
                                  ]
                              ),
                            ),

                            // Text("Today at 7:00"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Text(snapshot.data!.busId,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("${snapshot.data!.tripDate.toWordedDate()} at ${snapshot.data!.setOffTime.format(context)}")
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }
        return Container();
    });
  }
}
