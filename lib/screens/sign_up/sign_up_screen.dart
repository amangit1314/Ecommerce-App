import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          // 18 size
          size: 18,
        ),
        elevation: 0,
        title: Text(
          "Sign Up",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                // 16 size
                fontSize: 16,
              ),
        ),
      ),
      body: const Body(),
    );
  }
}
