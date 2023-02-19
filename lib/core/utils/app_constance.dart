import 'package:chruch/core/global/theme/app_color/app_color_light.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConstance {
  static bool _isCupertino() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
    }
  }


  static Widget get circularProgressIndicator => !_isCupertino()
      ? CircularProgressIndicator(color: AppColorsLight.scaffoldBackgroundColor)
      : CupertinoActivityIndicator(
          color: AppColorsLight.scaffoldBackgroundColor);
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
