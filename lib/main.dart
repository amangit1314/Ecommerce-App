import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/ecommerce.dart';
import 'package:soni_store_app/firebase_options.dart';

import 'helper/locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

Future<void> _listenToOnMessage(RemoteMessage message) async {
  log('Got a message whilst in the foreground!');
  log('Message data: ${message.data}');

  if (message.notification != null) {
    log('Message also contained a notification: ${message.notification}');
  }
}

void main() async {
  // * Enduring Initialization of Widget Binding in Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // * Initializing Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // * Locating Dependenices for Dependency Injection
  setupLocator();

  // * Notifications methods
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_listenToOnMessage);

  // * Function to run the Material App
  runApp(const EcommerceApp());
}
