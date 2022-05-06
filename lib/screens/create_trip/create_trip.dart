import 'package:vroom_core/models/app_state.dart';
import 'package:vroom_core/models/bus.dart';
import 'package:vroom_core/models/trip.dart';
import 'package:vroom_core/widgets/custom_button.dart';
import 'package:vroom_core/widgets/custom_dropdown.dart';
import 'package:vroom_core/widgets/custom_text_field.dart';
import 'package:vroom_core/widgets/input_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom_core/utils/constants.dart';
import 'package:vroom_core/utils/extensions.dart';
import 'package:vroom_core/utils/firestore_helper.dart';

class CreateTrip extends StatefulWidget {
  final Trip? trip;
  final Bus bus;
  const CreateTrip({required this.bus, this.trip, Key? key}) : super(key: key);

  @override
  _CreateTripState createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  TextEditingController pickup = TextEditingController();
  TextEditingController dropOff = TextEditingController();
  TextEditingController fare = TextEditingController();
  DateTimeRange range = DateTimeRange(start: DateTime.now(), end: DateTime.now());
  TimeOfDay setOffTime = const TimeOfDay(hour: 8, minute: 0);
  late Bus bus;
  late String busPlate;

  @override
  void initState() {
    super.initState();
    bus = widget.bus;
    busPlate = widget.bus.busRegistrationNumber;
    fare.text = "3.00";

    if (widget.trip != null) {
      pickup.text = widget.trip!.pickupLocation;
      dropOff.text = widget.trip!.dropOffLocation;
      fare.text = widget.trip!.fare.toString();
      range = DateTimeRange(start: widget.trip!.tripDate, end: widget.trip!.tripDate);
      setOffTime = widget.trip!.setOffTime;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title:  Text(widget.trip != null ? "Edit a trip" : "Create a trip"),
      ),
        backgroundColor: ashesiRedLight,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Trip details",
                  style: Theme.of(context).textTheme.headlineSmall!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
              ),


              InputSection(
                labels: const [
                  "Bus",
                  "Pickup Location",
                  "Drop off location",
                  "Fare",
                  "Departure days",
                  "Set off time"
                ],
                  inputs: [

                    FutureBuilder<List<Bus>>(
                      future: getAllBuses(),
                    // initialData: [bus],
                    builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done){
                          return CustomDropdown<String>(
                              value: busPlate,
                              items:List.generate(snapshot.data!.length, (index) => DropdownMenuItem(
                                child: Text(snapshot.data![index].busRegistrationNumber),
                                value: snapshot.data!.elementAt(index).busRegistrationNumber,
                              )),
                              onChanged: (selected){
                                setState(() {
                                  busPlate = selected;
                                  bus = snapshot.data!.firstWhere((element) => element.busRegistrationNumber == busPlate);
                                  // bus = selected;
                                });
                              });
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Text("Loading buses")
                            ],
                          );
                        }
                    }
                    ),


                    CustomTextField(
                        controller: pickup,
                      hintText: "Eg: Accra",
                    ),

                    CustomTextField(
                        controller: dropOff,
                      hintText: "Eg: Ashesi University"
                    ),
                    CustomTextField(
                        controller: fare,
                      hintText: "3.00"
                    ),

                    ListTile(
                      title: Text(range.asString()),
                      onTap: () async{
                        DateTime today = DateTime.now();

                       DateTimeRange? selected = await  showDateRangePicker(
                            context: context,
                            initialDateRange: range,
                            firstDate: today ,
                            lastDate: today.add(const Duration(days: 100))
                        );

                       if (selected != null){
                         setState(() {
                         });
                       }
                      },
                    ),
                    ListTile(
                      title: Text(setOffTime.format(context)),
                      onTap: () async{

                       TimeOfDay? selected = await  showTimePicker(
                            context: context, initialTime: setOffTime,
                        );

                       if (selected != null){
                         setState(() {
                           setOffTime = selected;
                         });
                       }
                      },
                    ),

                  ]
              ),
              CustomButton(
                radius: 4,
                text: widget.trip != null ? "Edit a trip" : "Create a trip",
                onPressed: ()async{
                  Trip trip = Trip(
                      busId: bus.id,
                      driverId: context.read<AppState>().auth!.currentUser!.uid,
                      capacity: 30,
                      tripId: "",
                      driverName: context.read<AppState>().auth!.currentUser!.displayName!,
                    fare: double.parse(fare.text),
                    driverNumber: "0559582518",
                    dropOffLocation: dropOff.text,
                    pickupLocation: pickup.text,
                    setOffTime: setOffTime,
                    tripDate: range.start
                  );

                  List<Future> upload = [];
                  for (DateTime date in range.toDateList()) {
                    trip.tripDate = date;
                    if (widget.trip != null) {
                      upload.add(editTrip(trip));
                    } else {
                       upload.add(uploadTrip(trip));
                    }
                  }
                  await Future.wait(upload);

                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
    );
  }
}
