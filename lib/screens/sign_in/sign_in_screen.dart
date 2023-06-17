import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/sign_in/components/body.dart';

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
        title: Text(
          "Sign In",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
        elevation: 0,
      ),
      body: const Body(),
    );
  }
}
