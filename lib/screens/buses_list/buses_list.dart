
import 'package:bus_driver/screens/buses_list/widget/bus_info_tile.dart';
import "package:flutter/material.dart";
import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/utils/firestore_helper.dart';
import 'package:vroom_core/models/bus.dart';


class BusesList extends StatefulWidget {
  const BusesList({Key? key}) : super(key: key);

  @override
  _BusesListState createState() => _BusesListState();
}

class _BusesListState extends State<BusesList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ashesiRedLight,
      appBar: AppBar(
        backgroundColor: ashesiRed,
        title: const Text("Buses"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Bus>>(
        future: getAllBuses(),
        initialData: [],
        builder: (context,snapshot){
          if (snapshot.hasData){
            if (snapshot.data!.isEmpty){
              return const Center(child: Text("There are no buses in the databbase"),);
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context,index)=>  BusInfoTile(bus: snapshot.data!.elementAt(index),)
            );
          }

          return Center(child: const Text("There seems to be some error"));

        },
      ),
    );
  }
}
