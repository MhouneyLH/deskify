import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../model/desk.dart';
import '../model/preset.dart';
import '../model/theme_settings.dart';

// interact with firebase
// basic CRUD-operations (CREATE, READ, UPDATE, DELETE)
// for desks and themes (currently)
// TODO: in future = profile, user-auth, etc.
class FirebaseApi {
  static const String deskCollectionName = 'desks';
  static const String themeCollectionName = 'themes';

  /// DESK ///
  static Future<String> createDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection(deskCollectionName).doc();

    desk.id = deskDocument.id;
    for (Preset preset in desk.presets) {
      preset.id = const Uuid().v4();
    }

    await deskDocument.set(desk.toJson());
    return deskDocument.id;
  }

  static Future<List<Desk>> readDesks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection(deskCollectionName).get();

    return querySnapshot.docs
        .map((document) => Desk.fromJson(document.data()))
        .toList();
  }

  static Future updateDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection(deskCollectionName).doc(desk.id);
    await deskDocument.update(desk.toJson());
  }

  static Future deleteDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection(deskCollectionName).doc(desk.id);
    await deskDocument.delete();
  }

  // no need for delete, as the user should not
  // be able to delete a theme
  /// THEME ///
  static Future<String> createTheme(ThemeSettings theme) async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);

    await themeDocument.set(theme.toJson());

    return themeDocument.id;
  }

  static Future<ThemeSettings> readTheme() async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);
    final themeSnapshot = await themeDocument.get();

    if (!themeSnapshot.exists) {
      final ThemeSettings newThemeSettings = ThemeSettings(isDarkTheme: true);

      await createTheme(newThemeSettings);
      return newThemeSettings;
    }

    return ThemeSettings.fromJson(themeSnapshot.data()!);
  }

  static Future<void> updateTheme(ThemeSettings theme) async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);

    await themeDocument.update(theme.toJson());
  }
}
