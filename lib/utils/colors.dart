import 'package:flutter/material.dart';

class Themes{
  Color greenPrimaryColor = const Color(0xFF1DB954);
  Color bluePrimaryColor = const Color(0xFF541DF9);
  Color redPrimaryColor = const Color(0xFFED820E);

  Color blackSecondaryColor = const Color(0xFF000000);
  Color whiteSecondaryColor = const Color(0xFFFFFFFF);

  Color blackTertiaryColor = const Color(0x44202020);
  Color whiteTertiaryColor = const Color(0x44F2F2F2);

  static ThemeData greenDarkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _theme.greenPrimaryColor,
      secondary: _theme.blackSecondaryColor
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _theme.greenPrimaryColor,
      titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 24)
    ),
    canvasColor: _theme.greenPrimaryColor
  );

  static ThemeData blueDarkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _theme.bluePrimaryColor,
      secondary: _theme.blackSecondaryColor
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _theme.bluePrimaryColor,
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 24)
    ),
    canvasColor: _theme.bluePrimaryColor
  );

  static ThemeData redDarkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
          primary: _theme.redPrimaryColor,
          secondary: _theme.blackSecondaryColor
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: _theme.redPrimaryColor,
          titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 24)
      ),
      canvasColor: _theme.redPrimaryColor
  );

  static ThemeData greenLightTheme = ThemeData(
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
          primary: _theme.greenPrimaryColor,
          secondary: _theme.whiteSecondaryColor
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: _theme.greenPrimaryColor,
          titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 24)
      ),
      canvasColor: _theme.greenPrimaryColor
  );

  static ThemeData blueLightTheme = ThemeData(
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
          primary: _theme.bluePrimaryColor,
          secondary: _theme.whiteSecondaryColor
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: _theme.bluePrimaryColor,
          titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 24)
      ),
      canvasColor: _theme.bluePrimaryColor
  );

  static ThemeData redLightTheme = ThemeData(
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
          primary: _theme.redPrimaryColor,
          secondary: _theme.whiteSecondaryColor
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: _theme.redPrimaryColor,
          titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 24)
      ),
      canvasColor: _theme.redPrimaryColor
  );
}

Themes _theme = Themes();
