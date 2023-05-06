import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deskify/model/desk.dart';

class FirebaseApi {
  static Future<String> createDesk(Desk desk) async {
    final deskDocument = FirebaseFirestore.instance.collection('desk').doc();

    desk.id = deskDocument.id;
    await deskDocument.set(desk.toJson());

    return deskDocument.id;
  }

  static Stream<List<Desk>> readDesks() => FirebaseFirestore.instance
      .collection('desk')
      .snapshots()
      // TODO: maybe using a transformer in future
      .map((snapshot) => snapshot.docs
          .map((document) => Desk.fromJson(document.data()))
          .toList());

  static Future updateDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection('desk').doc(desk.id);
    await deskDocument.update(desk.toJson());
  }

  static Future deleteDesk(Desk desk) async {
    final deskDocument =
        FirebaseFirestore.instance.collection('desk').doc(desk.id);
    await deskDocument.delete();
  }
}
