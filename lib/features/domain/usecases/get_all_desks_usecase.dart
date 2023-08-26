import 'package:dartz/dartz.dart';
import '../repository/desk_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';

class GetAllDesksUsecase implements Usecase<void, GetAllDesksParams> {
  final DeskRepository repository;

  GetAllDesksUsecase({required this.repository});

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, List<Desk>>> call(GetAllDesksParams params) async {
    return await repository.getAllDesks();
  }
}

class GetAllDesksParams extends Equatable {
  @override
  List<dynamic> get props => [];
}
