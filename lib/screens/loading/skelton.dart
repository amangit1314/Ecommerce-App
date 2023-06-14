import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/size_config.dart';

class Skelton extends StatelessWidget {
  final double? height, width;
  const Skelton({this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenHeight(8),
        vertical: getProportionateScreenWidth(8),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.04),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
