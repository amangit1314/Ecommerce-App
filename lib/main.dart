import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soni_store_app/ecommerce.dart';
import 'package:soni_store_app/firebase_options.dart';

import 'helper/locator.dart';

void main() async {
  // * Enduring Initialization of Widget Binding in Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // * Initializing Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // * Locating Dependenices for Dependency Injection
  setupLocator();

  // * handling ask for permission to send notification
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  // * Notifications methods
  FirebaseMessaging.instance.getInitialMessage();

  // * Function to run the Material App
  runApp(const EcommerceApp());
}
