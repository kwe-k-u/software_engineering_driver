

import 'package:bus_driver/models/RouteLocation.dart';
import 'package:bus_driver/models/driver.dart';

class Bus{
  final String id;
  final String imageUrl;
  final double fare;
  final String busRegistrationNumber;
  final DateTime departureTime;
  final int maxCapacity;
  final int bookedSeats;
  final RouteLocation pickup;
  final RouteLocation dropOff;
  final Driver driver;

  bool get isFull => maxCapacity == bookedSeats;
  bool get hasDeparted => departureTime.isAfter(DateTime.now());

  Bus({
    required this.id,
    required this.imageUrl,
    required this.fare,
    required this.busRegistrationNumber,
    required this.driver,
    required this.departureTime,
    required this.maxCapacity,
    required this.bookedSeats,
    required this.pickup,
    required this.dropOff,

});


  factory Bus.fromJson(Map<String,dynamic> map) => Bus(
    id: map["id"],
    imageUrl: map["imageUrl"],
    fare: map["fare"],
    busRegistrationNumber: map["busRegistrationNumber"],
    departureTime: DateTime.parse(map["departureTime"]),
    maxCapacity: map["maxCapacity"],
    bookedSeats: map["bookedSeats"],
    driver: Driver.fromJson(map["driver"]),
    pickup: RouteLocation.fromJson(map["pickup"]),
    dropOff: RouteLocation.fromJson(map["dropOff"])
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "imageUrl" : imageUrl,
    "fare" : fare,
    "busRegistrationNumber" : busRegistrationNumber,
    "departureTime" : departureTime,
    "maxCapacity" : maxCapacity,
    "bookedSeats" : bookedSeats,
    "driver" : driver.toJson(),
    "pickup" : pickup.toJson(),
    "dropOff" : dropOff.toJson()
  };





}


