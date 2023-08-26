import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';

abstract class DeskRepository {
  Future<Either<Failure, void>> createDesk(Desk desk);
  Future<Either<Failure, List<Desk>>> getAllDesks();
  Future<Either<Failure, Desk>> getDeskById(String id);
  Future<Either<Failure, void>> updateDesk(Desk desk);
  Future<Either<Failure, void>> deleteDesk(String id);
}
