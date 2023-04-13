import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: const IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeData? _themeData;
  ThemeData get themeData => _themeData ?? _darkTheme;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }
}
