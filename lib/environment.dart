

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String get filename => ".env";

  static String get apiKey => dotenv.env["API_KEY"]!;
  static String get productId => dotenv.env["PRODUCT_ID"]!;
  static String get messagingSenderId => dotenv.env["MESSAGING_SENDER_ID"]!;
  static String get appId => dotenv.env["APP_ID"]!;
  static String get flutterwavePublicKey => dotenv.env["FLUTTERWAVE_PUBLIC_KEY"]!;
  static String get flutterwaveSecretKey => dotenv.env["FLUTTERWAVE_SECRET_KEY"]!;
  static String get flutterwaveEncryptionKey => dotenv.env["FLUTTERWAVE_ENCRYPTION_KEY"]!;
}