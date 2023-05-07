import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/model/theme_settings.dart';
import 'package:uuid/uuid.dart';

class FirebaseApi {
  // TODO: writing api-functions for presets + profile
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

  static Stream<List<Desk>> readDesks() => FirebaseFirestore.instance
      .collection(deskCollectionName)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => Desk.fromJson(document.data()))
          .toList());

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

  /// THEME ///
  static Future<String> createTheme(ThemeSettings theme) async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);

    await themeDocument.set(theme.toJson());

    return themeDocument.id;
  }

  static Stream<ThemeSettings> readTheme() => FirebaseFirestore.instance
      .collection(themeCollectionName)
      .snapshots()
      .map((snapshot) => ThemeSettings.fromJson(snapshot.docs.first.data()));

  static Future updateTheme(ThemeSettings theme) async {
    final themeDocument = FirebaseFirestore.instance
        .collection(themeCollectionName)
        .doc(themeCollectionName);

    await themeDocument.update(theme.toJson());
  }
}
