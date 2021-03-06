import 'package:vroom_core/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:vroom_core/models/app_state.dart';
import 'package:bus_driver/screens/homepage/widgets/ticket_verfication_and_upcoming.dart';
import 'package:vroom_core/widgets/trip_tile.dart';
import 'package:provider/provider.dart';
import 'package:vroom_core/widgets/profile_image.dart';
import 'package:vroom_core/utils/constants.dart';
import 'package:vroom_core/utils/extensions.dart';
import 'package:vroom_core/utils/firestore_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime busDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Good morning,\n",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                              text: context.read<AppState>().auth!.currentUser!.displayName!,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontSize: 26)
                          )
                        ]
                    )
                ),
                ProfileImage(image: context.read<AppState>().auth!.currentUser!.photoURL,)

              ],
            ),
          ),


          const TicketVerificationAndUpcoming(),


          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Upcoming Trips ",
                  style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                TextButton(
                    onPressed: ()async{
                      DateTime? selected = await showDatePicker(
                          context: context,

                          initialDate: busDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      setState(() {
                        busDate = selected ?? DateTime.now();
                      });
                    },
                    child: Text("Select day", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ashesiRed),))
              ],
            ),
          ),
          Expanded(
            child:FutureBuilder<List<Trip>>(
              future: getTrips(date: busDate),
              builder: (context,snapshot) {
                if (snapshot.connectionState == ConnectionState.done){
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return  ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index)=> TripTile(
                          trip: snapshot.data![index],
                        onPressed: (){},
                      )
                  );
                  } else {
                    return Center(child: Text("No Trips on ${busDate.asString()}"),);
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
