import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ecommerce.dart';
import 'firebase_options.dart';
import 'helper/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLocator();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  FirebaseMessaging.instance.getInitialMessage();

  String stripePublishableKey = dotenv.get('STRIPE_PUBLISHABLE_KEY');
  Stripe.publishableKey = stripePublishableKey;

  runApp(const EcommerceApp());
}
