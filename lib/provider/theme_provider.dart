import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    accentColor: Colors.brown,
  );

  // final ThemeData _lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primarySwatch: Colors.blue,
  //   accentColor: Colors.brown,
  // );

  ThemeData? _themeData;
  ThemeData get themeData => _themeData ?? _darkTheme;

  void setDarkTheme() {
    _themeData = _darkTheme;
    notifyListeners();
  }

  // void setLightTheme() {
  //   _themeData = _lightTheme;
  //   notifyListeners();
  // }
}
