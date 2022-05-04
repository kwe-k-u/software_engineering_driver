import "package:flutter/material.dart";
import 'package:bus_driver/models/notification.dart';
import 'package:bus_driver/screens/notification_screen/widgets/notification_tile.dart';
import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/utils/firestore_helper.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ashesiRedLight,
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: ashesiRed,
      ),
      body: FutureBuilder<List<NotificationModel>>(
        initialData: const [],
        future: getNotifications(),
        builder: (context,snapshot){
          if (snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          switch (snapshot.connectionState){

            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              if (snapshot.hasData){
                if (snapshot.data!.isNotEmpty){
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index)=> NotificationTile(
                        notification: snapshot.data![index],
                      )
                  );
                }
              }
              return const Center(child: Text("There are no notifications"),);
            case ConnectionState.none:
              return const Center(child: Text("Something must be wrong"),);
          }


        },
      ),
    );
  }
}
