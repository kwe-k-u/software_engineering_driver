

import 'package:flutter/material.dart';

class Trip{
  String tripId;
  String busId;
  String driverName;
  String driverNumber;
  String pickupLocation;
  String dropOffLocation;
  double fare;
  int capacity;
  TimeOfDay setOffTime;
  DateTime tripDate;

  Trip({
   required this.tripId,
   required this.busId,
   required this.driverName,
   required this.driverNumber,
   required this.pickupLocation,
   required this.dropOffLocation,
   required this.fare,
   required this.capacity,
    required this.setOffTime,
    required this.tripDate
});



  factory Trip.fromJson(Map<String, dynamic> map) => Trip(
      tripId: map["tripId"],
      busId: map["busId"],
      driverName: map["driverName"],
      driverNumber: map["driverNumber"],
      pickupLocation: map["pickupLocation"],
      dropOffLocation: map["dropOffLocation"],
      fare: map["fare"],
      capacity: map["capacity"],
    tripDate: DateTime.parse(map["tripDate"]),
    setOffTime: TimeOfDay.fromDateTime(DateTime.parse(map["setOffTime"]))
  );

  Map<String,dynamic> toJson()=> {

    "tripId": tripId,
    "busId": busId,
    "driverName": driverName,
    "driverNumber": driverNumber,
    "pickupLocation": pickupLocation,
    "dropOffLocation": dropOffLocation,
    "fare": fare,
    "capacity": capacity,
    "tripDate" : DateTime(tripDate.year, tripDate.month, tripDate.day).toIso8601String(),
    "setOffTime" : DateTime(tripDate.year, tripDate.month,setOffTime.hour, setOffTime.minute).toIso8601String(),

  };
}