import 'package:flutter/material.dart';

// settings for the themes, like colorsSchemes, fontSizes,
// if it is currently dark- or light-theme, etc.
class ThemeSettings {
  bool isDarkTheme;
  late ThemeData themeData = isDarkTheme ? darkTheme : lightTheme;
  final Color standingColor = Colors.green;
  final Color sittingColor = Colors.red;

  static final ThemeData darkTheme = ThemeData(
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF6C63FF),
      inversePrimary: Colors.white,
      onPrimary: Colors.white,
      secondary: Color(0xFFE9ECEF),
      onSecondary: Color(0xFF212529),
      tertiary: Color.fromARGB(255, 160, 120, 64),
      onTertiary: Colors.white,
      surface: Color(0xFF343A40),
      inverseSurface: Colors.white,
      onSurface: Colors.white,
      background: Color(0xFF121212),
      onBackground: Colors.white,
      error: Color(0xFFD9534F),
      onError: Colors.white,
      errorContainer: Color(0xFFF2DEDE),
      onErrorContainer: Color(0xFFD9534F),
      onInverseSurface: Colors.black,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Color(0xFF343A40),
      onSurfaceVariant: Colors.grey,
      onTertiaryContainer: Colors.white,
      outline: Color(0xFF6C63FF),
      outlineVariant: Color(0xFFE9ECEF),
      primaryContainer: Color(0xFF6C63FF),
      secondaryContainer: Color(0xFFE9ECEF),
      shadow: Color(0xFF121212),
      scrim: Color.fromRGBO(0, 0, 0, 0.5),
      surfaceTint: Color.fromRGBO(0, 0, 0, 0.5),
      tertiaryContainer: Color(0xFF343A40),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6C63FF),
      inversePrimary: Colors.white,
      onPrimary: Colors.white,
      secondary: Color(0xFFE9ECEF),
      onSecondary: Color(0xFF212529),
      tertiary: Color.fromARGB(255, 160, 120, 64),
      onTertiary: Colors.white,
      surface: Colors.white,
      inverseSurface: Color(0xFF343A40),
      onSurface: Color(0xFF212529),
      background: Color(0xFFF8F9FA),
      onBackground: Color(0xFF212529),
      error: Color(0xFFD9534F),
      onError: Colors.white,
      errorContainer: Color(0xFFF2DEDE),
      onErrorContainer: Color(0xFFD9534F),
      onInverseSurface: Colors.white,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      onSurfaceVariant: Colors.grey,
      onTertiaryContainer: Color(0xFF212529),
      outline: Color(0xFF6C63FF),
      outlineVariant: Color(0xFFE9ECEF),
      primaryContainer: Color(0xFF6C63FF),
      secondaryContainer: Color(0xFFE9ECEF),
      shadow: Color.fromRGBO(0, 0, 0, 0.1),
      scrim: Color.fromRGBO(255, 255, 255, 0.5),
      surfaceTint: Color.fromRGBO(255, 255, 255, 0.5),
      tertiaryContainer: Colors.white,
    ),
  );

  ThemeSettings({required this.isDarkTheme});

  static ThemeSettings fromJson(Map<String, dynamic> json) => ThemeSettings(
        isDarkTheme: json['isDarkTheme'],
      );

  Map<String, dynamic> toJson() => {
        'isDarkTheme': isDarkTheme,
      };
}
