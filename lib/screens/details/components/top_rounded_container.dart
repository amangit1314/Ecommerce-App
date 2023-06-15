import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(40)),
          topRight: Radius.circular(getProportionateScreenWidth(40)),
        ),
      ),
      child: child,
    );
  }
}
