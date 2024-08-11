import 'package:flutter/material.dart';

class AppTheme{


  static const Color primaryColor = Color.fromRGBO(131, 160, 158, 1);
  static const Color accentColor = Color.fromRGBO(218, 196, 176, 1);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color buttonColor = Color.fromRGBO(189,142,139, 1);

static ThemeData get lightTheme {
    return ThemeData(
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      primaryColor: primaryColor,
      secondaryHeaderColor: accentColor,
      cardColor: accentColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
      ),
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        titleTextStyle: 
           TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
  }
}