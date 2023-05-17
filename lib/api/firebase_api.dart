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
  // create a new desk
  // deskId is the id of the desk-document in the database
  // presetId is a UUID-generated Id
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

  // read all desks from the database
  static Future<List<Desk>> readDesks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection(deskCollectionName).get();

    return querySnapshot.docs
        .map((document) => Desk.fromJson(document.data()))
        .toList();
  }

  // update the value of a desk in the database
  static Future updateDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection(deskCollectionName).doc(desk.id);
    await deskDocument.update(desk.toJson());
  }

  // delete a desk from the database
  static Future deleteDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection(deskCollectionName).doc(desk.id);
    await deskDocument.delete();
  }

  // no need for delete, as the user should not
  // be able to delete a theme
  /// THEME ///
  // create a new theme in the database (used when no theme-document exists)
  static Future<String> createTheme(ThemeSettings theme) async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);

    await themeDocument.set(theme.toJson());

    return themeDocument.id;
  }

  // read the theme from the database
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

  // update the theme in the database
  static Future<void> updateTheme(ThemeSettings theme) async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);

    await themeDocument.update(theme.toJson());
  }
}
