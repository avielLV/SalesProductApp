import 'package:flutter/material.dart';

class ThemeApp {
  static Color prymari = Colors.deepPurple;
  static ThemeData themeApp = ThemeData.light().copyWith(
      primaryColor: prymari,
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: AppBarTheme(elevation: 0, color: prymari),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: prymari, elevation: 0));
}
