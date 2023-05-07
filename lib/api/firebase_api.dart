import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:uuid/uuid.dart';

class FirebaseApi {
  // TODO: writing api-functions for presets + profile
  static const String deskCollectionName = 'desks';

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
}
