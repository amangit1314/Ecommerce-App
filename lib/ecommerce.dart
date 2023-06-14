import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:soni_store_app/providers/address_provider.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/providers/review_provider.dart';
import 'package:soni_store_app/resources/services/auth/auth_service.dart';
import 'package:soni_store_app/screens/home/home_screen.dart';
import 'package:soni_store_app/screens/splash/splash_screen.dart';

import 'config/secret_keys.dart';
import 'helper/locator.dart';

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  // final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeeds
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  // }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear(); // Removes all listeners
  }

  var options = {
    'key': RazorPay().razorPayKeyId,
    'amount': 50000, //in the smallest currency sub-unit.
    'name': 'SnapCart',
    'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Fine T-Shirt',
    'timeout': 60, // in seconds
    'prefill': {'contact': '9649477393', 'email': 'gitaman8481@gmail.com'}
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => locator<AuthService>()),
        ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ProductProvider>()),
        ChangeNotifierProvider(create: (_) => locator<CartProvider>()),
        ChangeNotifierProvider(create: (_) => locator<OrderProvider>()),
        ChangeNotifierProvider(create: (_) => locator<PaymentProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => locator<AddressProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ReviewProvider>()),
      ],
      child: GetMaterialApp(
        title: 'SnapCart Ecommerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'Poppins',
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.data != null) {
                Provider.of<AuthProvider>(context, listen: false)
                    .getUserDetails(snapshot.data!);

                log(snapshot.data.toString());
                return const HomeScreen();
              }
              return const SplashScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
