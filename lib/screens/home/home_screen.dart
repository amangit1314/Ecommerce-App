import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soni_store_app/components/custom_bottom_nav_bar.dart';
import 'package:soni_store_app/screens/home/components/body.dart';

import '../../utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? paymentIntent;
  String? mtoken = " ";

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    saveToken(mtoken!);
    // makePayment();
    // displayPaymentSheet();
    // createPaymentIntent();
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
        return null;
      },
    );
  }

  void saveToken(String token) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  // makePayment() async {
  //   try {
  //     paymentIntent = await createPaymentIntent();
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: paymentIntent!['client_secret'],
  //         applePay: const PaymentSheetApplePay(
  //           merchantCountryCode: 'US',
  //         ),
  //         googlePay: const PaymentSheetGooglePay(
  //           merchantCountryCode: 'US',
  //         ),
  //         style: ThemeMode.dark,
  //         merchantDisplayName: 'SnapCart',
  //       ),
  //     );
  //     displayPaymentSheet();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //   } catch (e) {
  //     debugPrint('faild');
  //   }
  // }

  // createPaymentIntent() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': 100,
  //       'currency': 'usd',
  //       'payment_method_types[]': 'card, upi'
  //     };

  //     http.Response response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       body: body,
  //       headers: {
  //         "Authorization": "Bearer TEST_TOKEN",
  //         "Content-Type": "application/x-www-form-urlencoded"
  //       },
  //     );

  //     return json.decode(response.body);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     throw (Exception(e.toString()));
  //   }
  // }

  void initInfo() async {
    try {
      // * Initialize Flutter Local Notifications
      var androidInitialize =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings =
          InitializationSettings(android: androidInitialize);
      await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
          onDidReceiveBackgroundNotificationResponse:
              (dynamic payload) async {});

      // * Retrieve Firebase Messaging token
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      log('Firebase Messaging Token: $token');

      // ? Request permission to display notifications (required for iOS)
      await messaging.requestPermission();
      NotificationSettings settings = await messaging.getNotificationSettings();
      log('Notification Settings: ${settings.authorizationStatus}');

      // ! Subscribe to a topic for receiving push notifications
      await messaging.subscribeToTopic('topic_name');
      log('Subscribed to topic.');

      // * Handle incoming messages when the app is in the foreground
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

      // ? Handle incoming messages when the app is in the background or terminated
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        log('Received background message: ${message.notification?.body}');
        // ! Perform custom handling of background messages
        // ! e.g., update app state, trigger background processing, etc.
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
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
