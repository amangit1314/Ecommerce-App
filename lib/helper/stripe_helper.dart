import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../providers/user_provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(
      String amount, BuildContext context, Order order) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret:
              paymentIntent!['client_secret'], // Gotten from payment intent
          style: ThemeMode.light,
          merchantDisplayName: 'Aman Soni',
          googlePay: gpay,
        ),
      );

      displayPaymentSheet(context, order);
    } catch (err) {
      // Handle error
    }
  }

  void displayPaymentSheet(BuildContext context, Order order) async {
    UserProvider? userProvider =
        Provider.of<UserProvider>(context, listen: false);

    Completer<bool> paymentCompleter = Completer<bool>();

    Stripe.instance.presentPaymentSheet().then((_) {
      paymentCompleter.complete(true);
    }).catchError((error) {
      paymentCompleter.complete(false);
    });

    bool isSuccess = await paymentCompleter.future;

    if (isSuccess) {
      Order newOrder = order;

      userProvider.orders?.add(newOrder);
    }

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
