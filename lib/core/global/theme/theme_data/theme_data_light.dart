import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_string.dart';
import '../app_color/app_color_light.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColorsLight.appBarBackground,
      foregroundColor: AppColorsLight.appBarForeground,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark)),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.white70,
    overlayColor: MaterialStateProperty.all(Colors.white12),
    dividerColor: Colors.transparent,
    indicatorColor: Colors.white,
    labelColor: Colors.white,
  ),
  textTheme: const TextTheme().copyWith(
    titleMedium: const TextStyle().copyWith(
      color: AppColorsLight.darkText,
      fontFamily: FontsFamily.inter,
    ),
    bodyMedium: const TextStyle().copyWith(
      color: AppColorsLight.darkText,
      fontFamily: FontsFamily.inter,

    ),
    titleLarge: const TextStyle().copyWith(
      color: AppColorsLight.darkText,
      fontFamily: FontsFamily.inter,

    ),
    titleSmall: const TextStyle().copyWith(
      color: AppColorsLight.darkText,
      fontFamily: FontsFamily.inter,

    ),
    labelMedium: const TextStyle().copyWith(
      color: AppColorsLight.darkText,
      fontFamily: FontsFamily.inter,

    ),
    headlineMedium: const TextStyle().copyWith(
      color: AppColorsLight.lightText,
      fontFamily: FontsFamily.inter,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ThemeData().colorScheme.copyWith(
      primary: AppColorsLight.primary, secondary: AppColorsLight.secondary),
  dialogTheme: DialogTheme(
    backgroundColor: AppColorsLight.scaffoldBackgroundColor,
    surfaceTintColor: AppColorsLight.scaffoldBackgroundColor,
    shadowColor: AppColorsLight.scaffoldBackgroundColor,
  ),
  primaryColor: AppColorsLight.primary,
  focusColor: AppColorsLight.primary,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColorsLight.primary,
    selectionColor: AppColorsLight.primary.withOpacity(.2),
    selectionHandleColor: AppColorsLight.primary.withOpacity(.9),
  ),
  iconTheme: const IconThemeData(
    color: AppColorsLight.iconThemeColor,
  ),
  scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
  useMaterial3: true,
);
