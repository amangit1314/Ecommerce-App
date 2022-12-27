import 'package:flutter/material.dart'
    show BuildContext, MediaQuery, MediaQueryData, Orientation;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double screenWidth = 360;
  static double screenHeight = 740;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    SizeConfig().init(context);
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 740.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 360.0) * screenWidth;
}
