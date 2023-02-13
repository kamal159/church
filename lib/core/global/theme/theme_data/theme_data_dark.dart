import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme().copyWith(
    titleMedium: const TextStyle().copyWith(color: Colors.white),
    bodyMedium: const TextStyle().copyWith(color: Colors.white),
    titleLarge: const TextStyle().copyWith(color: Colors.white),
  ),
  // scaffoldBackgroundColor: Colors.grey.shade900,
  useMaterial3: true,
);
