


import 'dart:io';

import 'package:bus_driver/models/bus.dart';
import 'package:bus_driver/models/notification.dart';
import 'package:bus_driver/models/ticket.dart';
import 'package:bus_driver/models/trip.dart';
import 'package:bus_driver/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<Trip>> getTrips({DateTime? date}) async {
  List<Trip> trips = [];
  DateTime _date = DateTime.now().noTime();

  if (date != null){
    _date = date.noTime();
  }


  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/bus_system/departure")
      .where("tripDate", isEqualTo: _date.toIso8601String()).get();
      // .collection(_date.toIso8601String()).get();



  for (QueryDocumentSnapshot<Map<String,dynamic>> trip in results.docs) {
    Map<String,dynamic> data = {};
    // data.addAll(trip.data());
    data.addAll(trip.data());
    data['id'] = trip.id;
    trips.add(Trip.fromJson(trip.data()));
    print("e");
  }

  return trips;
}

// Future<List<Ticket>> getUserHistory(String id) async {
//   List<Ticket> reciepts = [];
//
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/bus_driver/departure")
//   .where("userId",isEqualTo: id).get();
//
//   for (QueryDocumentSnapshot<Map<String,dynamic>> document in results.docs){
//     reciepts.add(Ticket.fromJson(document.data()));
//   }
//
//
//
//   return reciepts;
// }


Future<List<Bus>> getAllBuses() async {
  List<Bus> bus = [];
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> docs = await firestore.collection("public/bus_system/buses").get();
  for (DocumentSnapshot<Map<String,dynamic>> info in docs.docs){
    print(info.data());
    bus.add(Bus.fromJson(info.data()!));
  }
  print(bus);
  return bus;
}



Future<List<NotificationModel>> getNotifications() async {
  List<NotificationModel> notifications = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/communication/notifications").get();
  // print(results.toString());

  for (QueryDocumentSnapshot<Map<String,dynamic>> document in results.docs){
    // print(document.data()['actions'] ?? NotificationAction.indicateLateness);
    notifications.add(NotificationModel.fromJson(document.data()));
  }
  // print(notifications);
  return notifications;
}


Future<String> uploadImage({required String id, required File image}) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  TaskSnapshot upload = await storage.ref("users/profile/$id").putFile(image);
  return await upload.ref.getDownloadURL();
}

Future<void> editTrip(Trip trip) async {
  //todo implement edit
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection("public/bus_system/departure").doc().set(trip.toJson());

}

Future<void> uploadTrip(Trip trip) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection("public/bus_system/departure").doc().set(trip.toJson());

}
