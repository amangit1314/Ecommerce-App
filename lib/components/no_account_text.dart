import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/sign_up/sign_up_screen.dart';
import 'package:tokoto_ecommerce_app/utils/constants.dart';

import '../utils/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
