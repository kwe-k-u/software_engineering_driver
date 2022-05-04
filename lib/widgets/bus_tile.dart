import 'dart:ui';

import 'package:bus_driver/screens/bus_details/bus_details.dart';
import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BusTile extends StatelessWidget {
  const BusTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            barrierColor: ashesiGrey.withOpacity(0.8),
            builder: (context)=> const BusDetails()
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: SizedBox(
          height: size.height * 0.21,
          width: size.width * 0.95,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //left column
                Column(
                  children: [
                    Placeholder(
                      fallbackWidth: size.width * 0.3,
                      fallbackHeight: size.height * 0.13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("No. GR 455 -17",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    )
                  ],
                ),

                //middle column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DestinationWidget(
                      label: "from",
                      location: "Accra",
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        color: ashesiRed,
                        height: double.maxFinite,
                        width: 2,
                      ),
                    ),
                    _DestinationWidget(
                      label: "to",
                      location: "Ashesi University",
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomButton(text: "Book", onPressed: (){}, radius: 8,),
                    Spacer(flex: 2,),
                    RichText(text: TextSpan(
                      text: "GHC ",
                      style: Theme.of(context).textTheme.labelLarge!
                        .copyWith(fontSize: 16),
                      children: [
                        TextSpan(
                          text: "3.00",
                          style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600,
                            fontSize: 24
                          )
                        )
                      ]
                    )),
                    Spacer()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class _DestinationWidget extends StatelessWidget {
  final String location;
  final String label;
  const _DestinationWidget({
    Key? key,
    required this.location,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.location_on_outlined, color: ashesiRed,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location, style: Theme.of(context).textTheme.labelLarge,),
            Text(label, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
          ],
        ),
      ],
    );
  }
}
