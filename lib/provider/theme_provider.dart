import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final Color _darkStandingColor = Colors.green;
  final Color _darkSittingColor = Colors.red;

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

  Color get darkStandingColor => _darkStandingColor;
  Color get darkSittingColor => _darkSittingColor;

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
