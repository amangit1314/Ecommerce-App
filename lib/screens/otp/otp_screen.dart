import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  final dynamic verificationId;
  static String routeName = "/otp";

  const OtpScreen({super.key, this.verificationId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Verify OTP",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
