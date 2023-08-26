import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';

class UpdateDeskUsecase implements Usecase<void, UpdateDeskParams> {
  final DeskRepository repository;

  UpdateDeskUsecase(this.repository);

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, void>> call(UpdateDeskParams params) async {
    return await repository.updateDesk(params.desk);
  }
}

class UpdateDeskParams extends Equatable {
  final Desk desk;

  const UpdateDeskParams({required this.desk});

  @override
  List<dynamic> get props => [desk];
}
