import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/core.dart';
import '../models/desk_model.dart';

abstract class DeskRemoteDataSource {
  Future<void> createDesk(DeskModel desk);
  Future<List<DeskModel>> getAllDesks();
  Future<DeskModel> getDeskById(String id);
  Future<void> updateDesk(DeskModel desk);
  Future<void> deleteDesk(String id);
}

class DeskRemoteDataSourceImpl implements DeskRemoteDataSource {
  final FirebaseFirestore instance;

  DeskRemoteDataSourceImpl({required this.instance});

  @override
  Future<void> createDesk(DeskModel desk) async {
    final deskDocument = instance.collection(deskCollectionName).doc();

    await deskDocument.set(desk.toMap());
  }

  @override
  Future<List<DeskModel>> getAllDesks() async {
    final snapshot = await instance.collection(deskCollectionName).get();

    final List<DeskModel> desks = [];
    for (final doc in snapshot.docs) {
      desks.add(DeskModel.fromMap(doc.data()));
    }

    return desks;
  }

  @override
  Future<DeskModel> getDeskById(String id) async {
    final snapshot =
        await instance.collection(deskCollectionName).doc(id).get();

    final DeskModel desk = DeskModel.fromMap(snapshot.data()!);
    return desk;
  }

  @override
  Future<void> updateDesk(DeskModel desk) async {
    final deskDocument = instance.collection(deskCollectionName).doc(desk.id);

    await deskDocument.update(desk.toMap());
  }

  @override
  Future<void> deleteDesk(String id) async {
    final deskDocument = instance.collection(deskCollectionName).doc(id);

    await deskDocument.delete();
  }
}
