import 'package:flutter/material.dart';
import 'package:soni_store_app/components/default_button.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../home/home_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.04),
        Image.network(
          "https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fsuccess.png?alt=media&token=69a74af2-5c47-41cd-88d1-cebdd3cc0b49",
          height: screenHeight * 0.4, //40%
        ),
        SizedBox(height: screenHeight * 0.04),
        const Text(
          "Login Success",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenWidth * 0.01)),
          child: Text(
            "Welcome we are thrilled with your presence \n You are successfully loged in 🎉",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const Spacer(flex: 7),
        Container(
          margin: const EdgeInsets.all(15),
          width: screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            txtColor: Colors.white,
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
