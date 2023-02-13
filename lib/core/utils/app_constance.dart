import 'package:flutter/cupertino.dart';

class AppConstance {
  static String? uId;
}

class AppConstanceScreenSize {
  static double widthScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double heightScreen(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double topPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double bottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
