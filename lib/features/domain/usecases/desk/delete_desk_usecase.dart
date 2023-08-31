import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../repository/desk_repository.dart';

class DeleteDeskUsecase implements Usecase<void, DeleteDeskParams> {
  final DeskRepository repository;

  DeleteDeskUsecase({required this.repository});

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
