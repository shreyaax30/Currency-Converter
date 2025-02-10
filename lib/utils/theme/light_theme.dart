import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
 brightness: Brightness.light,
 appBarTheme: AppBarTheme(
  backgroundColor: Colors.black,
  foregroundColor: Colors.black,
 ),
 colorScheme: ColorScheme.light(
  surface: Color.fromARGB(255, 225, 225, 225),
  primary: Color.fromARGB(255, 225, 225, 225),
  secondary: Color.fromARGB(255, 223, 222, 222),
  onSecondary: Colors.black,
  tertiary: Color.fromARGB(255, 214, 214, 214),
 ),
);