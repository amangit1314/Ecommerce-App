import 'package:flutter/material.dart';
import 'package:soni_store_app/components/no_account_text.dart';
import 'package:soni_store_app/resources/auth_methods.dart';
import 'package:soni_store_app/screens/sign_in/components/sign_in_form.dart';

import '../../../components/social_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // show white_new_logo
              SizedBox(
                height: screenHeight * 0.08,
                child: Image.asset("assets/icons/white_new_logo.png"),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign in with your email and password",
                // \nor continue with social media
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: screenHeight * 0.05),
              const Padding(
                padding: EdgeInsets.only(left: 18.0, right: 18.0),
                child: SignForm(),
              ),
              SizedBox(height: screenHeight * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: "assets/icons/google-icon.svg",
                    press: () => AuthMethods().signInWithGoogle(),
                  ),
                  SocialCard(
                    icon: "assets/icons/facebook-2.svg",
                    press: () {},
                  ),
                  SocialCard(
                    icon: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
