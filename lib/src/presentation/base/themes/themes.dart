import 'package:flutter/material.dart';

class Themes {
  static const TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      fontFamily: 'FiraSans',
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'FiraSans',
    ),
    headline3: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'FiraSans',
    ),
    headline4: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      fontFamily: 'FiraSans',
    ),
    headline5: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'FiraSans',
    ),
    headline6: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: 'FiraSans',
    ),
    subtitle1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'FiraSans',
    ),
    subtitle2: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      fontFamily: 'FiraSans',
    ),
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'FiraSans',
    ),
  );

  static final light = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color.fromRGBO(125, 29, 29, 1.0),
      onPrimary: Color.fromRGBO(251, 244, 244, 1),
      secondary: Color.fromRGBO(255, 255, 255, 1),
      onSecondary: Color.fromRGBO(59, 12, 12, 1.0),
      tertiary: Color.fromRGBO(226, 226, 226, 1),
      onTertiary: Color.fromRGBO(255, 206, 212, 1),
      surface: Color.fromRGBO(252, 166, 166, 1.0),
      onSurface: Color.fromRGBO(251, 244, 244, 0.8),
      background: Color.fromRGBO(239, 223, 223, 1.0),
      onBackground: Color.fromRGBO(59, 12, 12, 1.0),
      brightness: Brightness.light,
      error: Color.fromRGBO(231, 0, 14, 1),
      onError: Color.fromRGBO(231, 0, 14, 1),
      primaryContainer: Color.fromRGBO(231, 0, 14, 1),
    ),
    textTheme: _textTheme,
  );

  static final dark = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color.fromRGBO(252, 166, 166, 1.0),
      onPrimary: Color.fromRGBO(59, 12, 12, 1.0),
      secondary: Color.fromRGBO(42, 8, 8, 1.0),
      onSecondary: Color.fromRGBO(255, 255, 255, 1),
      tertiary: Color.fromRGBO(96, 96, 96, 1),
      onTertiary: Color.fromRGBO(255, 206, 212, 1),
      surface: Color.fromRGBO(80, 15, 15, 1.0),
      onSurface: Color.fromRGBO(251, 244, 244, 0.6),
      background: Color.fromRGBO(27, 31, 27, 1),
      onBackground: Color.fromRGBO(251, 244, 244, 1),
      brightness: Brightness.dark,
      error: Color.fromRGBO(231, 0, 14, 1),
      onError: Color.fromRGBO(231, 0, 14, 1),
      primaryContainer: Color.fromRGBO(251, 244, 244, 1),
    ),
    textTheme: _textTheme,
  );
}
