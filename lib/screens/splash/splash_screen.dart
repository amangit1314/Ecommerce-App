import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/utils/size_config.dart';

import 'comonents/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

/**
 * 
 * void initState(){
 *    Timer(Duration(seconds: 2), () => Navigator.pushReplacement(
 *      context, 
 *      PageTransition(child: SignUpView, type: PageTransition.rightToLeft)  
 *    );
 *    super.initState();
 *  )}
 * 
 */
