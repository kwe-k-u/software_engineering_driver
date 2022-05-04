import 'package:flutter/material.dart';
import 'package:bus_driver/models/notification.dart';
import 'package:bus_driver/utils/constants.dart';
import 'package:bus_driver/utils/extensions.dart';


class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("from", style: Theme.of(context).textTheme.labelMedium!
                      .copyWith(
                    color: Colors.grey
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(notification.sender.name.capitalise(), style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  const Spacer(),
                  // Icon(i)
                  Text(notification.dateSent.asString())
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(notification.message),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: genActions(context),
              )
            ],
          ),
        ),
      ),
    );
  }



  List<Widget> genActions(BuildContext context){
    List<Widget> list = [];

    if (notification.actions!= null){
      for (NotificationAction element in notification.actions!) {
        switch (element){
          case NotificationAction.indicateLateness:
            list.add(TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(top: 16,left: 4, right:4, bottom: 0)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              child: Text("Indicate lateness", style: Theme.of(context).textTheme.bodyLarge!
                  .copyWith(color: ashesiRed),),
              onPressed: (){},
            ));
            break;
        }
      }
    }


    return list;
  }
}
