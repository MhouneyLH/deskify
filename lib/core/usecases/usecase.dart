import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// A usecase is a class that executes business logic.
///
/// This is the base class for all usecases.
abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// A usecase that does not require any parameters.
///
/// This is the base class for all usecases that do not require any parameters.
class NoParams extends Equatable {
  @override
  List<dynamic> get props => [];
}
