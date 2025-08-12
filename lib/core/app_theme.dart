import 'package:flutter/material.dart';

final primaryColor = const Color.fromARGB(255, 56, 71, 146);
final secondryColor = const Color.fromARGB(255, 79, 102, 216);
final appTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.light(primary: primaryColor),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: primaryColor, fontSize: 16),
    iconColor: secondryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondryColor),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
);
