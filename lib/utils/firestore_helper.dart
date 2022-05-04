


import 'dart:io';

import 'package:vroom_core/models/bus.dart';
import 'package:vroom_core/models/notification.dart';
import 'package:vroom_core/models/ticket.dart';
import 'package:vroom_core/models/trip.dart';
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
  }

  return trips;
}

Future<Trip?> getUpcomingTrip (String userId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  print("userid $userId");
  QuerySnapshot<Map<String, dynamic>> result = await firestore
      .collection("public/bus_system/departure")
      .where("driverId", isEqualTo: userId)
      .limit(1)
      .get();
  if (result.docs.isNotEmpty){
    return Trip.fromJson(result.docs.first.data());
  }

  return null;
}

Future<List<Bus>> getAllBuses() async {
  List<Bus> bus = [];
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> docs = await firestore.collection("public/bus_system/buses").get();
  for (DocumentSnapshot<Map<String,dynamic>> info in docs.docs){
    bus.add(Bus.fromJson(info.data()!));
  }
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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection("public/bus_system/departure").doc(trip.tripId).set(trip.toJson());

}

Future<void> uploadTrip(Trip trip) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference doc = firestore.collection("public/bus_system/departure").doc();
  trip.tripId = doc.id;
  await doc.set(trip.toJson());

}

Future<List<Ticket>> getTripTickets(String tripId) async {
  List<Ticket> tickets = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/transactions/tickets").where("tripId", isEqualTo: tripId).get();

  for (DocumentSnapshot<Map<String,dynamic>> doc in results.docs){
    tickets.add(Ticket.fromJson(doc.data()!));
  }
  
  return tickets;
}


Future<Ticket?> getTripById(String id) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Map<String, dynamic>> result = await firestore.collection("public/transactions/tickets").doc(id).get();
  if (result.exists){
    return Ticket.fromJson(result.data()!);
  }
  return null;
}