import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deskify/api/firebase_api.dart';
import 'package:deskify/model/theme_settings.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData = _darkTheme;
  ThemeSettings _currentThemeSettings = ThemeSettings(isDarkTheme: true);

  ThemeProvider() {
    _subscribeToThemeChanges();
  }

  final Color _standingColor = Colors.green;
  final Color _sittingColor = Colors.red;

  final ThemeData _darkTheme = ThemeData(
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

  final ThemeData _lightTheme = ThemeData(
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

  Color get standingColor => _standingColor;
  Color get sittingColor => _sittingColor;

  ThemeData get themeData => _themeData;
  ThemeSettings get currentThemeSettings => _currentThemeSettings;

  void _subscribeToThemeChanges() => FirebaseFirestore.instance
          .collection(FirebaseApi.themeCollectionName)
          .snapshots()
          .listen(
        (snapshot) {
          getTheme();
          _themeData =
              _currentThemeSettings.isDarkTheme ? _darkTheme : _lightTheme;
        },
      );

  void addTheme(ThemeSettings theme) => FirebaseApi.createTheme(theme);

  void getTheme() async {
    final ThemeSettings fetchedThemeSettings = await FirebaseApi.readTheme();
    _currentThemeSettings = fetchedThemeSettings;
    // has to set theme data here explicitly, as it just get the themeSettings-data and
    // does not trigger the lister in _subscribeToThemeChanges()
    _themeData = _currentThemeSettings.isDarkTheme ? _darkTheme : _lightTheme;

    notifyListeners();
  }

  void updateTheme(bool isDarkTheme) {
    _currentThemeSettings.isDarkTheme = isDarkTheme;

    FirebaseApi.updateTheme(_currentThemeSettings);
    notifyListeners();
  }
}
