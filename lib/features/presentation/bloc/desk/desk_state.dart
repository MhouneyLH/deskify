part of 'desk_bloc.dart';

sealed class DeskState extends Equatable {
  const DeskState();

  @override
  List<Object> get props => [];
}

sealed class CreateDeskState extends DeskState {
  const CreateDeskState();
}

sealed class Failure extends DeskState {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class Empty extends DeskState {}

final class CreateDeskFetching extends DeskState {}

final class CreateDeskSuccess extends DeskState {}

final class CreateDeskFailure extends Failure {
  const CreateDeskFailure({required super.message});
}

final class GetAllDesksFetching extends DeskState {}

final class GetAllDesksSuccess extends DeskState {
  final List<Desk> desks;

  const GetAllDesksSuccess({
    required this.desks,
  });

  @override
  List<Object> get props => [desks];
}

final class GetAllDesksFailure extends Failure {
  const GetAllDesksFailure({required super.message});
}

final class GetDeskByIdFetching extends DeskState {}

final class GetDeskByIdSuccess extends DeskState {
  final Desk desk;

  const GetDeskByIdSuccess({
    required this.desk,
  });

  @override
  List<Object> get props => [desk];
}

final class GetDeskByIdFailure extends Failure {
  const GetDeskByIdFailure({required super.message});
}

final class UpdateDeskFetching extends DeskState {}

final class UpdateDeskSuccess extends DeskState {}

final class UpdateDeskFailure extends Failure {
  const UpdateDeskFailure({required super.message});
}

final class DeleteDeskFetching extends DeskState {}

final class DeleteDeskSuccess extends DeskState {}

final class DeleteDeskFailure extends Failure {
  const DeleteDeskFailure({required super.message});
}

final class UpdateCurrentDeskSuccess extends DeskState {
  final Desk currentDesk;

  const UpdateCurrentDeskSuccess({
    required this.currentDesk,
  });

  @override
  List<Object> get props => [currentDesk];
}
