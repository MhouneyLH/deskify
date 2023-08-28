import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';
import '../repository/desk_repository.dart';

class GetAllDesksUsecase implements Usecase<void, NoParams> {
  final DeskRepository repository;

  GetAllDesksUsecase({required this.repository});

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, List<Desk>>> call(NoParams params) async {
    return await repository.getAllDesks();
  }
}