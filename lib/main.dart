import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soni_store_app/ecommerce.dart';
import 'package:soni_store_app/firebase_options.dart';
import 'package:soni_store_app/resources/services/notification/notification.dart';

import 'helper/locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

Future<void> _listenToOnMessage(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
          android: AndroidNotificationDetails('channel.id', 'channel.name')),
      payload: json.encode(message.data),
    );
  }
}

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
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_listenToOnMessage);

  // * Function to run the Material App
  runApp(const EcommerceApp());
}
