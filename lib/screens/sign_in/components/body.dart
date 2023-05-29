import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/components/no_account_text.dart';
import 'package:soni_store_app/screens/sign_in/components/sign_in_form.dart';

import '../../../components/social_card.dart';
import '../../../providers/providers.dart';
import '../../otp/enter_mobile_number.dart';

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

              SizedBox(height: screenHeight * 0.04),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
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
                    press: () async {
                      AuthProvider authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      try {
                        await authProvider.authenticateWithGoogle();
                        // Authentication successful, perform necessary actions or navigate to next screen
                      } catch (error) {
                        // Handle authentication error
                        log("Google authentication error: $error");
                      }
                    },
                  ),
                  SocialCard(
                    icon: "assets/icons/Phone.svg",
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MobileNumberScreen(),
                        ),
                      );
                    },
                  ),
                  // SocialCard(
                  //   icon: "assets/icons/facebook-2.svg",
                  //   press: () {},
                  // ),
                  // SocialCard(
                  //   icon: "assets/icons/twitter.svg ",
                  //   press: () {},
                  // ),
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
