import 'package:flutter/material.dart';
import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/widgets/ticket_reciept.dart';


class TicketReceiptTile extends StatelessWidget {
  const TicketReceiptTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 2),
      child: InkWell(
        onTap: (){
          showDialog(context: context, builder: (context)=> TicketReciept());
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.check_circle_rounded, color: Colors.green,),
                  title: Text("TicketID: NX-265-6584"),
                  subtitle: Text("Paid with Momo"),
                  trailing: Text("GHC 3.00", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("from", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),),
                        Text("Christ The King"),
                        Text("Accra")
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.access_time, color: ashesiRed, size: 28,),
                        Text("Today at 7:45 AM")
                      ],
                    ),
                    Column(
                      children: [
                        Text("To", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),),
                        Text("Ashesi University"),
                        Text("Berekusu")
                      ],
                    ),
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
