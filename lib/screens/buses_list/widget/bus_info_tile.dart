import 'package:bus_driver/models/bus.dart';
import 'package:bus_driver/screens/create_trip/create_trip.dart';
import 'package:bus_driver/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/widgets/ticket_reciept.dart';


class BusInfoTile extends StatelessWidget {
  final Bus bus;
  const BusInfoTile({required this.bus, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 2),
      child:  Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          elevation: 6,
          child: Container(
            width: double.maxFinite,
            height: size.height * 0.2,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.2,
                      child: Image.network(bus.imageUrl,
                        width: size.width * 0.08,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(Icons.broken_image_outlined,
                            size: size.width * 0.16,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(text: TextSpan(
                          text: "Plate number: ",
                          style: Theme.of(context).textTheme.bodyText2,
                          children: [
                            TextSpan(
                              text: bus.busRegistrationNumber,
                              style: Theme.of(context).textTheme.titleLarge

                            )
                          ]
                        )),
                        RichText(text: TextSpan(
                          text: "Bus capacity: ",
                          style: Theme.of(context).textTheme.bodyText2,
                          children: [
                            TextSpan(
                              text: bus.maxCapacity.toString(),
                              style: Theme.of(context).textTheme.titleMedium

                            )
                          ]
                        )),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>  CreateTrip(bus: bus,)
                              )
                          );
                        },
                        child: Text("Create Trip",
                          style: Theme.of(context).textTheme.bodyText1!
                          .copyWith(color: ashesiRed),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}
