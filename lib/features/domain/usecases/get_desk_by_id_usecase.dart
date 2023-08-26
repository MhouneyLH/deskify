import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../entities/desk.dart';

class GetDeskByIdUsecase implements Usecase<void, GetDeskByIdParams> {
  final DeskRepository repository;

  GetDeskByIdUsecase(this.repository);

  // use of callable classes
  // otherwise this class just would have 1 function named "execute()" or something like that
  @override
  Future<Either<Failure, Desk>> call(GetDeskByIdParams params) async {
    return await repository.getDeskById(params.deskId);
  }
}

class GetDeskByIdParams extends Equatable {
  final Id deskId;

  const GetDeskByIdParams({required this.deskId});

  @override
  List<dynamic> get props => [deskId];
}
