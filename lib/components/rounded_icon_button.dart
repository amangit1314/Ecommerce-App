import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 10,
              color: const Color.fromARGB(255, 146, 144, 144).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(
        style: flatButtonStyle,
        onPressed: press,
        child: Icon(
          icon,
          color: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
