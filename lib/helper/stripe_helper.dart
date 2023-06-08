// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'package:soni_store_app/providers/order_provider.dart';

// import '../models/order.dart';

// class StripeHelper {
//   static StripeHelper instance = StripeHelper();

//   Map<String, dynamic>? paymentIntent;

//   Future<void> makePayment(
//       String amount, Order order, OrderProvider orderProvider) async {
//     try {
//       paymentIntent = await createPaymentIntent(amount, 'USD');

//       var gpay = const PaymentSheetGooglePay(
//         merchantCountryCode: "US",
//         currencyCode: "USD",
//         testEnv: true,
//       );

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent!['client_secret'],
//           style: ThemeMode.light,
//           merchantDisplayName: 'Aman Soni',
//           googlePay: gpay,
//         ),
//       );

//       displayPaymentSheet(order, orderProvider);
//     } catch (err) {
//       // Handle error
//     }
//   }

//   void displayPaymentSheet(Order order, OrderProvider orderProvider) async {
//     Completer<bool> paymentCompleter = Completer<bool>();

//     Stripe.instance.presentPaymentSheet().then((_) {
//       paymentCompleter.complete(true);
//     }).catchError((error) {
//       paymentCompleter.complete(false);
//     });

//     bool isSuccess = await paymentCompleter.future;

//     if (isSuccess) {
//       Order newOrder = order;
//       orderProvider.addOrder(newOrder);
//     }

//     await Future.delayed(const Duration(seconds: 2));
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: body,
//       );

//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
// }

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

  // displayPaymentSheet() async {import '../../utils/enums.dart';
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