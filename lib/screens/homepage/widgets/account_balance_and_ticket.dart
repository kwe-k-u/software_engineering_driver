import 'package:bus_driver/models/app_state.dart';
import 'package:bus_driver/models/ticket.dart';
import 'package:bus_driver/utils/firestore_helper.dart';
import 'package:bus_driver/utils/payment_handler.dart';
import 'package:bus_driver/widgets/custom_button.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';



class AccountBalanceAndTicket extends StatefulWidget {
  const AccountBalanceAndTicket({Key? key}) : super(key: key);

  @override
  _AccountBalanceAndTicketState createState() => _AccountBalanceAndTicketState();
}

class _AccountBalanceAndTicketState extends State<AccountBalanceAndTicket> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(16),
      child: Expanded(
        child: Column(
          children: const [

            _CreditBalance(),
            _UnusedTickets()

          ],
        ),
      ),
    );
  }
}





class _CreditBalance extends StatelessWidget {
  const _CreditBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.zero,
      child:
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Ashesi Bus Credit Balance",
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                  FutureBuilder<double>(
                    initialData: 0,
                    future: getAdvancePaymentBalance(context.read<AppState>().auth!.currentUser!.uid),
                      builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("GHC ${snapshot.data!.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w800),
                        );
                      }
                      return Text("There seems to be an error",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                      );
                      }),
                ],
              ),
              CustomButton(
                  text: "TOP UP",
                  onPressed: ()async{
                    await PaymentHandler.initiatePayment(context: context, amount: 3.00, fullName: "Kweku Acquaye");

                  },
                radius: 6,
              )
            ],
      ),
        ),
    );
  }
}




class _UnusedTickets extends StatelessWidget {
  const _UnusedTickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Ticket?>(
      future: getUnusedTicket(context.read<AppState>().auth!.currentUser!.uid),
        builder: (context, snapshot) => snapshot.hasData ? Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          child:
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Unused Tickets",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text("Active")
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Ashesi",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                children:[
                                  TextSpan(text: " to ",
                                      style: Theme.of(context).textTheme.bodyText2
                                  ),
                                  TextSpan(
                                      text: "Accra"
                                  ),
                                ]
                            ),
                          ),

                          Text("Bus leaves today at 7:00"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("GHC 3.00",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Bought on ",
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                      text: "22 Feb 2022",
                                      style: Theme.of(context).textTheme.bodyLarge
                                  )
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) : SizedBox( width: 0,height: 0,)
    );
  }
}
