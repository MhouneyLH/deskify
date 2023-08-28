import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';

/// This class is the repository for the [Desk] entity.
///
/// It collects functions that are used to interact with the data layer.
abstract class DeskRepository {
  Future<Either<Failure, void>> createDesk(Desk desk);
  Future<Either<Failure, List<Desk>>> getAllDesks();
  Future<Either<Failure, Desk>> getDeskById(String id);
  Future<Either<Failure, void>> updateDesk(Desk desk);
  Future<Either<Failure, void>> deleteDesk(String id);
}
