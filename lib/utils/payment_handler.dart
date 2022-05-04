

import 'package:bus_driver/environment.dart';
import 'package:bus_driver/models/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:provider/provider.dart';

class PaymentHandler {

  static Future<void> initiatePayment({
    required BuildContext context,
    String currency = "GHS",
    required double amount,
    required String fullName,

  }) async {
    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: Environment.flutterwavePublicKey,
      currency: currency,
      amount: amount.toString(),
      txRef: context.read<AppState>().auth!.currentUser!.uid + DateTime.now().toIso8601String(),
      isTestMode: true,
      customer: Customer(
          name: "Kweku Acquaye",
          email: context.read<AppState>().auth!.currentUser!.email!,
        phoneNumber: "0559582518"
      ),
        paymentOptions: "card, mobilemoneyghana",
        customization: Customization()
    );

    ChargeResponse response = await flutterwave.charge();
    print(response.toJson());

    // final ChargeResponse response = await flutterwave.initializeForUiPayments();
  }
}



// Flutterwave flutterwave = Flutterwave.forUIPayment(
//   context: context,
//   encryptionKey: Environment.flutterwaveEncryptionKey,
//   publicKey: Environment.flutterwavePublicKey,
//   currency: currency,
//   amount: amount.toString(),
//   email: context.read<AppState>().auth!.currentUser!.email!,
//   fullName: fullName,
//   txRef: "txref",
//   isDebugMode: true,
//   phoneNumber: "0559582518",
//   acceptCardPayment: false,
//   acceptUSSDPayment: true,
//   acceptAccountPayment: true,
//   acceptGhanaPayment: true,
//   // acceptFrancophoneMobileMoney: true
// );
