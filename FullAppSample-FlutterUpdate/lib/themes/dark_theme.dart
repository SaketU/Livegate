import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      surface: Colors.black12,//Color(0Xff242525), //shade 900 or black 26 or [850]! the original background
      primary: Colors.grey.shade900, //sender text (left)
      secondary: Colors.white.withValues(),//Colors.white38,//receiver text (right)
      tertiary: Colors.white, //Nav bar icons and letter on right
      primaryContainer: Colors.grey.shade800, //Logo Beginning Container
      secondaryContainer: Colors.black26, //chat background black26
      tertiaryContainer: Colors.white10, //header and keyboard chat
      onPrimary: Colors.black26,
      onSecondary: Colors.white, //letters on left
    onTertiary: Colors.grey.shade400 //live now, time, share
),
);
