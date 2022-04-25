import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text("Sign In"),
        elevation: 0,
      ),
      body: Body(),
    );
  }
}
