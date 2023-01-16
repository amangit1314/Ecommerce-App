import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/screens/sign_up/sign_up_screen.dart';
import 'package:soni_store_app/utils/constants.dart';

import '../utils/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 72.0),
      child: Row(
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.to(const SignUpScreen()),
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
