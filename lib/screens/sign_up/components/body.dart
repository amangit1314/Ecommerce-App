import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../components/social_card.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../login_success/login_success_screen.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text(
                  "Register Account",
                  style: headingStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01), // 4%
                const Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                const SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
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
                                              title:
                                                  'Authentication Successful',
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
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
