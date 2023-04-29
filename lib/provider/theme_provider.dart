import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final Color _standingColor = Colors.green;
  final Color _sittingColor = Colors.red;

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.brown,
    accentColor: Colors.brown,
  );

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.brown,
    accentColor: Colors.brown,
  );

  Color get darkStandingColor => _standingColor;
  Color get darkSittingColor => _sittingColor;
  bool get isDarkTheme => _themeData == _darkTheme;

  late ThemeData _themeData = _darkTheme;
  ThemeData get themeData => _themeData;

  void setDarkTheme() {
    _themeData = _darkTheme;
    notifyListeners();
  }

  void setLightTheme() {
    _themeData = _lightTheme;
    notifyListeners();
  }
}
