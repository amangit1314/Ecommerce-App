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

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / screenHeight) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / screenWidth) * screenWidth;
}
