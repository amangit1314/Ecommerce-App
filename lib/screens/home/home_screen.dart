import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soni_store_app/components/custom_bottom_nav_bar.dart';
import 'package:soni_store_app/screens/home/components/body.dart';

import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../support_chat/support_chat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? mtoken = " ";

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    saveToken(mtoken!);
    initInfo();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          mtoken = token;
        });
        saveToken(token!);
        return mtoken;
      },
    );
  }

  void saveToken(String token) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'token': token}, SetOptions(merge: true));

    showLocalNotification(
      '',
      '',
      const BigTextStyleInformation(
        'Welcome to SnapCart',
        htmlFormatBigText: true,
        contentTitle: 'SnapCart',
      ),
    );
  }

  void initInfo() async {
    try {
      // Initialize Flutter Local Notifications
      const AndroidInitializationSettings androidInitialize =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: androidInitialize);
      await FlutterLocalNotificationsPlugin()
          .initialize(initializationSettings);

      // Retrieve Firebase Messaging token
      final FirebaseMessaging messaging = FirebaseMessaging.instance;
      final String? token = await messaging.getToken();
      log('Firebase Messaging Token: $token');

      // Assign the token to mtoken
      setState(() {
        mtoken = token;
      });

      // Request permission to display notifications (required for iOS)
      await messaging.requestPermission();
      final NotificationSettings settings =
          await messaging.getNotificationSettings();
      log('Notification Settings: ${settings.authorizationStatus}');

      // Subscribe to a topic for receiving push notifications
      await messaging.subscribeToTopic('topic_name');
      log('Subscribed to topic.');

      // Handle incoming messages when the app is in the foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('....................................');
        log('onMessage: ${message.notification?.title}/${message.notification?.body}');
        log('....................................');

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification?.title,
        );

        showLocalNotification(
          message.notification?.title,
          message.notification?.body,
          bigTextStyleInformation,
        );
      });
    } catch (e) {
      log('Initialization error: $e');
    }
  }

  void showLocalNotification(String? title, String? body,
      BigTextStyleInformation? bigTextStyleInformation) {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      styleInformation: bigTextStyleInformation,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    FlutterLocalNotificationsPlugin()
        .show(0, title, body, platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SupportChat(),
            ),
          );
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.support_agent),
      ),
    );
  }
}
