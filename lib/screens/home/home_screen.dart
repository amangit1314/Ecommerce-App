import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
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
  }

  void requestPermission() async {
    // permision for firebase notification
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

    // check for authorization state
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
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
    // get uid of current user
    String uid = FirebaseAuth.instance.currentUser!.uid;
    // save token to database
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'token': token,
    });
  }

  makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
          ),
          style: ThemeMode.dark,
          merchantDisplayName: 'Soni Store',
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('faild');
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        'amount': 100,
        'currency': 'usd',
        'payment_method_types[]': 'card, upi'
      };

      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          "Authorization": "Bearer TEST_TOKEN",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      return json.decode(response.body);
    } catch (e) {
      print(e);
      throw (Exception(e.toString()));
    }
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
