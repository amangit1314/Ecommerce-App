import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/splash/comonents/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
