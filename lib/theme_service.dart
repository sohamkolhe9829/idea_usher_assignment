import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeService {
  final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(color: Colors.white),
    textTheme: TextTheme(labelMedium: TextStyle(color: Colors.black)),
    splashColor: HexColor("#C4C4C4"),
    cardColor: HexColor("#F0F0F0"),
  );
  final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(labelMedium: TextStyle(color: Colors.white)),
    splashColor: HexColor("#8A8A8A"),
    cardColor: HexColor("#323232"),
    appBarTheme: AppBarTheme(color: Colors.black),
  );
}
