import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
  colorScheme: ColorScheme.light(
surface: Colors.white,
  primary: Colors.grey.shade200,
  secondary: Color(0Xff242525), // before black87
  tertiary: Colors.black,
    primaryContainer: Colors.grey.shade300,
    secondaryContainer: Colors.white,
    tertiaryContainer: Colors.white,
    onPrimary: Colors.grey.shade200,
    onSecondary: Colors.white,
    onTertiary: Colors.grey.shade600, //Color(0Xff242525)
),
);