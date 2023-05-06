import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deskify/model/desk.dart';
import 'package:uuid/uuid.dart';

class FirebaseApi {
  // TODO: writing api-functions for presets + profile
  static const String deskCollectionName = 'desk';

  static Future<String> createDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection(deskCollectionName).doc();

    desk.id = deskDocument.id;
    for (int i = 0; i < desk.presets.length; i++) {
      desk.presets[i].id = const Uuid().v4();
    }
    await deskDocument.set(desk.toJson());

    return deskDocument.id;
  }

  static Stream<List<Desk>> readDesks() => FirebaseFirestore.instance
      .collection(deskCollectionName)
      .snapshots()
      // TODO: maybe using a transformer in future
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
