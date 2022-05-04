import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusDetails extends StatefulWidget {
  const BusDetails({Key? key}) : super(key: key);

  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: size.height * 0.8,
        child: Theme(
          data: ThemeData(
            iconTheme: const IconThemeData(
              color: ashesiRed,
              size: 38
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Placeholder(
                  fallbackWidth: size.width * 0.6,
                  fallbackHeight: size.height * 0.25,
                ),
              ),


              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Placeholder(
                          fallbackWidth: size.width * 0.09,
                          fallbackHeight: size.width * 0.15,
                        ),
                      ),
                      const Text("Driver")
                    ],
                  ),

                  InkWell(
                    onTap: () async{
                      await launch("tel://+233 55 854 7888");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mr. Thomas",
                          style: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(
                            fontWeight: FontWeight.w500
                          )
                        ),

                        RichText(text: TextSpan(
                          text: "Bus No. ",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                              fontWeight: FontWeight.w500
                          ),
                          children: [
                            TextSpan(
                              text: "GT 542 21",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal)
                            )
                          ]
                        )),


                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.green, size: 24,),
                            Text("+233 55 854 7888"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.supervisor_account_rounded),
                  Column(
                    children: [
                      Text("Capacity", style: Theme.of(context).textTheme.headline6,),
                      Text("23/30", style: Theme.of(context).textTheme.bodyLarge,)
                    ],
                  )
                ],
              ),

              const Spacer(),

              Row(
                children: [
                  _DestinationWidget(
                    location: "Ashesi",
                    label: "from",
                  ),
                  const Spacer(),


                  const Icon(Icons.access_time),
                  Column(
                    children: [
                      Text("Departure", style: Theme.of(context).textTheme.headline6,),
                      Text("5.00 PM")
                    ],
                  ),

                ],
              ),


              Container(
                color: Colors.black,
                width: 1,
                margin: EdgeInsets.only(left: size.width * 0.03),
                height: size.height * 0.1,
              ),

              Row(
                children: [
                  _DestinationWidget(
                    location: "Kwabenya",
                    label: "To",
                  ),
                  const Spacer(),


                  const Icon(Icons.money, color: ashesiRed,),
                  RichText(text: TextSpan(
                    text: "GHC ",
                    style: Theme.of(context).textTheme.headline6,
                    children: [
                      TextSpan(
                        text: "3.00",
                        style: Theme.of(context).textTheme.headline5
                      )
                    ]
                  )
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class _DestinationWidget extends StatelessWidget {
  final String label;
  final String location;
  const _DestinationWidget({
    Key? key,
    required this.label,
    required this.location
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined),
        Column(
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall,),
            Text(location, style: Theme.of(context).textTheme.titleLarge,),
          ],
        ),
      ],
    );
  }
}

