


import 'dart:io';

import 'package:bus_driver/models/bus.dart';
import 'package:bus_driver/models/notification.dart';
import 'package:bus_driver/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<Bus>> getAvailableBuses({DateTime? date}) async {
  List<Bus> buses = [];
  DateTime _date = DateTime.now();

  if (date == null){//if no bus date is given, check buses for today
    DateTime now = DateTime.now();
    _date = DateTime(now.year, now.month, now.day);
  } else {
    _date = DateTime(date.year, date.month, date.day);
  }


  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  QuerySnapshot<Map<String, dynamic>> results = await firestore.doc("public/bus_driver")
      .collection("0").get();
      // .collection(_date.toIso8601String()).get();


  for (QueryDocumentSnapshot<Map<String,dynamic>> trip in results.docs) {
    Map<String,dynamic> data = {};
    data["id"] = DateTime.parse(trip.id);
    data.addAll(trip.data());
    buses.add(Bus.fromJson(trip.data()));
  }

  return buses;
}

Future<List<Ticket>> getUserHistory(String id) async {
  List<Ticket> reciepts = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/bus_driver/departure")
  .where("userId",isEqualTo: id).get();

  for (QueryDocumentSnapshot<Map<String,dynamic>> document in results.docs){
    reciepts.add(Ticket.fromJson(document.data()));
  }



  return reciepts;
}

Future<double> getAdvancePaymentBalance(String userId) async{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Map<String, dynamic>> results = await firestore.doc("public/user_info/$userId/advance_balance").get();

  if (results.exists){
    return results.data()!["balance"];
  }

  return 0;
}


Future<void> makeAdvancePayment({required String userId, required double amount}) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Map<String, dynamic>> balance = await firestore.doc("public/user_info/$userId/advance_balance").get();

  if (balance.exists) {
    double current = await balance.data()!["balance"];
    current += amount;
    await balance.reference.update({"balance" : current});
  } else {
    await balance.reference.set({"balance" : amount});
  }
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

Future<Ticket?> getUnusedTicket(String userId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore
      .collection("public/communication/notifications").where("userId",isEqualTo: "userId" )
      .where("status", isEqualTo: "active").get();
  // print(results.toString());

  if (results.docs.isNotEmpty){
    return Ticket.fromJson(results.docs.first.data());
  }

  return null;
}
