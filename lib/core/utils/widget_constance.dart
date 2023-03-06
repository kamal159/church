import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../global/theme/app_color/app_color_light.dart';

class WidgetConstance {
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
