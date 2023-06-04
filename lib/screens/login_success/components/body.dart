import 'package:flutter/material.dart';
import 'package:soni_store_app/components/default_button.dart';

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
        SizedBox(height: screenHeight * 0.08),
        const Text(
          "Login Success",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
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
      ],
    );
  }
}
