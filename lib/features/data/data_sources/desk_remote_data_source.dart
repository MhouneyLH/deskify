import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/core.dart';
import '../models/desk_model.dart';

/// Desk related remote data source.
///
/// This class is responsible for all desk related calls to the [Firestore] API.
abstract class DeskRemoteDataSource {
  /// Calls the [Firestore] API to create a new [DeskModel].
  /// The desk's id gets generated by Firestore.
  ///
  /// Throws an [APIException] for all error codes.
  Future<void> createDesk(DeskModel desk);

  /// Calls the [Firestore] API to get all [DeskModels] stored in the database.
  ///
  /// Throws an [APIException] for all error codes.
  Future<List<DeskModel>> getAllDesks();

  /// Calls the [Firestore] API to get a specific [DeskModel] by its id.
  ///
  /// Throws an [APIException] for all error codes.
  Future<DeskModel> getDeskById(String id);

  /// Calls the [Firestore] API to update a specific [DeskModel].
  ///
  /// Throws an [APIException] for all error codes.
  Future<void> updateDesk(DeskModel desk);

  /// Calls the [Firestore] API to delete a specific [DeskModels] by its id.
  ///
  /// Throws an [APIException] for all error codes.
  Future<void> deleteDesk(String id);
}

class DeskRemoteDataSourceImpl implements DeskRemoteDataSource {
  final FirebaseFirestore firestoreInstance;

  DeskRemoteDataSourceImpl({required this.firestoreInstance});

  @override
  Future<void> createDesk(DeskModel desk) async {
    try {
      final deskDocument =
          firestoreInstance.collection(deskCollectionName).doc();

      desk.id = deskDocument.id;

      await deskDocument.set(desk.toMap());
    } on Exception catch (_) {
      throw APIException(message: 'createDesk');
    }
  }

  @override
  Future<List<DeskModel>> getAllDesks() async {
    try {
      final snapshot =
          await firestoreInstance.collection(deskCollectionName).get();

      final List<DeskModel> desks = [];
      for (final doc in snapshot.docs) {
        desks.add(DeskModel.fromMap(doc.data()));
      }

      return desks;
    } on Exception catch (_) {
      throw APIException(message: 'getAllDesks');
    }
  }

  @override
  Future<DeskModel> getDeskById(String id) async {
    final snapshot =
        await firestoreInstance.collection(deskCollectionName).doc(id).get();

    final DeskModel desk = DeskModel.fromMap(snapshot.data()!);
    return desk;
  }

  @override
  Future<void> updateDesk(DeskModel desk) async {
    final deskDocument =
        firestoreInstance.collection(deskCollectionName).doc(desk.id);

    await deskDocument.update(desk.toMap());
  }

  @override
  Future<void> deleteDesk(String id) async {
    final deskDocument =
        firestoreInstance.collection(deskCollectionName).doc(id);

    await deskDocument.delete();
  }
}
