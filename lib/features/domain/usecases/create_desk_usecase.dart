import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';

class CreateDeskUsecase implements Usecase<void, CreateDeskParams> {
  final DeskRepository repository;

  CreateDeskUsecase(this.repository);

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, void>> call(CreateDeskParams params) async {
    return await repository.createDesk(params.desk);
  }
}

class CreateDeskParams extends Equatable {
  final Desk desk;

  const CreateDeskParams({required this.desk});

  @override
  List<dynamic> get props => [desk];
}
