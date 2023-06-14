import 'package:flutter/material.dart';

import '../../../utils/constatns.dart';
import '../../../utils/size_config.dart';

class SplashContent extends StatelessWidget {
  final String text, image;

  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "Snap Cart",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Image.network(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
