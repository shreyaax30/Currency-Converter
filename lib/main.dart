import 'package:currencyconverter/screens/home_screen.dart';
import 'package:currencyconverter/utils/theme/dark_theme.dart';
import 'package:currencyconverter/utils/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Convertor',
      theme: lightTheme,  //Auto-follows device theme
      darkTheme: darkTheme, //Auto-follows device theme
     
      home : HomeScreen(),
    );
  }
}