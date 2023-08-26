import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

class CreateDeskUsecase implements Usecase<void, Params> {
  final DeskRepository repository;

  CreateDeskUsecase(this.repository);

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.getAllDesks();
  }
}

class Params extends Equatable {
  @override
  List<dynamic> get props => [];
}
