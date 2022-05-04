import 'package:flutter/material.dart';

class QrCodeConfirmPage extends StatefulWidget {
  final String ticketId;
  const QrCodeConfirmPage({
    Key? key,
    required this.ticketId
  }) : super(key: key);

  @override
  _QrCodeConfirmPageState createState() => _QrCodeConfirmPageState();
}

class _QrCodeConfirmPageState extends State<QrCodeConfirmPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: size.width,
              height:  size.height * 0.2,
              child: Text("Scanned ID: ${widget.ticketId}"),
            ),

            Expanded(
              child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 3)),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.done){
                    if (snapshot.data == null){
                      return Center(child: Text("${widget.ticketId} doesn't exist in the database"),);
                    } else {
                      return Text("Ticket information"); //todo implement inferface to view ticket details and mark as used
                    }
                  }
                  return Center(child:
                    Row(
                      children: [
                        CircularProgressIndicator(),
                        Text("Verifying ID")
                      ],
                    ),);
                },
              ),
            )
          ],
        )
    );
  }
}
