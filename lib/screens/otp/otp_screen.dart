import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/otp/components/body.dart';

import '../../utils/size_config.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";

  const OtpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: const Body(),
    );
  }
}
