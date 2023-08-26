import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

class DeleteDeskUsecase implements Usecase<void, DeleteDeskParams> {
  final DeskRepository repository;

  DeleteDeskUsecase(this.repository);

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, void>> call(DeleteDeskParams params) async {
    return await repository.deleteDesk(params.deskId);
  }
}

class DeleteDeskParams extends Equatable {
  final Id deskId;

  const DeleteDeskParams({required this.deskId});

  @override
  List<dynamic> get props => [deskId];
}
