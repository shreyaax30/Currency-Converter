import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
 brightness: Brightness.dark,
 appBarTheme: AppBarTheme(
  backgroundColor: Colors.black,
  foregroundColor: Colors.white70,
 ),
 colorScheme: ColorScheme.dark(
  surface: Color.fromARGB(255, 20, 21, 23),
  primary: Color.fromARGB(255, 20, 21, 23),
  onPrimary:  Color.fromARGB(200, 255, 255, 255),
  secondary: Color.fromARGB(255, 40, 38, 38),
  onSecondary: Color.fromARGB(200, 255, 255, 255),
  tertiary: Color.fromARGB(255, 27, 27, 27),
  
 )
);