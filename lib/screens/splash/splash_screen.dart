import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/splash/comonents/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    //SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      // body: Scaffold(
      //   body: Center(
      //       child: GestureDetector(
      //           child: const Text("Splash Screen"), onTap: () {})),
      // ),
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
