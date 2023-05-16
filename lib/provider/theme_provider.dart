import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deskify/api/firebase_api.dart';
import 'package:deskify/model/theme_settings.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeSettings _themeSettings = ThemeSettings(isDarkTheme: true);

  ThemeProvider() {
    _subscribeToThemeChanges();
  }

  Color get standingColor => _themeSettings.standingColor;
  Color get sittingColor => _themeSettings.sittingColor;
  ThemeData get themeData => _themeSettings.themeData;
  ThemeSettings get themeSettings => _themeSettings;

  void _subscribeToThemeChanges() => FirebaseFirestore.instance
          .collection(FirebaseApi.themeCollectionName)
          .snapshots()
          .listen(
        (snapshot) {
          getTheme();
          _themeSettings.themeData = _themeSettings.isDarkTheme
              ? ThemeSettings.darkTheme
              : ThemeSettings.lightTheme;
        },
      );

  void getTheme() => WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          final ThemeSettings fetchedThemeSettings =
              await FirebaseApi.readTheme();
          _themeSettings = fetchedThemeSettings;
          // has to set theme data here explicitly, as it just get the themeSettings-data and
          // does not trigger the lister in _subscribeToThemeChanges()
          _themeSettings.themeData = _themeSettings.isDarkTheme
              ? ThemeSettings.darkTheme
              : ThemeSettings.lightTheme;

          notifyListeners();
        },
      );

  void updateTheme(bool isDarkTheme) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _themeSettings.isDarkTheme = isDarkTheme;

          FirebaseApi.updateTheme(_themeSettings);
          notifyListeners();
        },
      );
}
