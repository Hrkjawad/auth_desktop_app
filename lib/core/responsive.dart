import 'package:flutter/widgets.dart';

class ResponsiveSize {
  static late double screenWidth;
  static late double screenHeight;
  static late bool isMobile;
  static late bool isDesktop;
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    isMobile = screenWidth <= 720;
    isDesktop = screenWidth >= 1024;
  }

  static double w(double percent) => screenWidth * percent / 100;

  static double h(double percent) => screenHeight * percent / 100;

}
