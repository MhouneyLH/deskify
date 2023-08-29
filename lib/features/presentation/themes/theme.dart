import 'package:flutter/material.dart';
import 'dark_theme.dart' as dark;
import 'light_theme.dart' as light;

/// This class defines the colors for the themes of the app.
class ThemeSettings {
  static final ThemeData darkTheme = dark.theme;
  static final ThemeData lightTheme = light.theme;

  static const double smallSpacing = 5.0;
  static const double mediumSpacing = 10.0;
  static const double largeSpacing = 20.0;
}
