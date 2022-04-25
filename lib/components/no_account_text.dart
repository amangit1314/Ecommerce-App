import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto_ecommerce_app/screens/sign_up/sign_up_screen.dart';
import 'package:tokoto_ecommerce_app/utils/constants.dart';

import '../utils/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 79.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(SignUpScreen()),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
