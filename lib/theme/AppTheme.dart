import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
    ),
  );
}