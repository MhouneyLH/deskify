import 'package:equatable/equatable.dart';

/// A failure is an error that occurs when a [Usecase] is executed.
///
/// This is the base class for all failures.
abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<dynamic> get props => [properties];
}

/// Custom [Failure] to handle API related errors.
class APIFailure extends Failure {}
