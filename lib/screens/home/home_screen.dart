import 'dart:convert';

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
