import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/components/no_account_text.dart';
import 'package:tokoto_ecommerce_app/screens/sign_in/components/sign_in_form.dart';

import '../../../components/social_card.dart';
import '../../../utils/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign in with your email and password  \nor continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.07),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: SignForm(),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: "assets/icons/google-icon.svg",
                    press: () {},
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
              SizedBox(height: getProportionateScreenHeight(20)),
              const NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
