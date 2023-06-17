import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/components/no_account_text.dart';
import 'package:soni_store_app/screens/login_success/login_success_screen.dart';
import 'package:soni_store_app/screens/sign_in/components/sign_in_form.dart';

import '../../../components/social_card.dart';
import '../../../providers/providers.dart';

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
                        await authProvider.authenticateWithGoogle().then(
                              (value) => value == "success"
                                  ? Navigator.of(context)
                                      .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginSuccessScreen(),
                                        ),
                                      )
                                      .then((value) => const GetSnackBar(
                                            backgroundColor: Colors.green,
                                            title: 'Authentication Successful',
                                            message:
                                                'Authentication is successful 🥳🎉',
                                            snackPosition: SnackPosition.TOP,
                                            duration: Duration(seconds: 3),
                                          ))
                                  : const GetSnackBar(
                                      backgroundColor: Colors.red,
                                      title: 'Authentication Failed ❌',
                                      message: 'Faild to Auth with Google',
                                      snackPosition: SnackPosition.TOP,
                                      duration: Duration(seconds: 3),
                                    ),
                            );
                        log("Google authentication Successfull 🎉");
                      } catch (error) {
                        log("Google authentication error: $error");
                      }
                    },
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
