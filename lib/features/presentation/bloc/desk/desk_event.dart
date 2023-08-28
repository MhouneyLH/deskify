part of 'desk_bloc.dart';

sealed class DeskEvent extends Equatable {
  const DeskEvent();

  @override
  List<Object> get props => [];
}

final class CreatedDesk extends DeskEvent {
  final Desk desk;

  const CreatedDesk({
    required this.desk,
  });

  @override
  List<Object> get props => [desk];
}

final class GotAllDesks extends DeskEvent {}

final class GotDeskById extends DeskEvent {
  final Id id;

  const GotDeskById({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

final class UpdatedDesk extends DeskEvent {
  final Desk desk;

  const UpdatedDesk({
    required this.desk,
  });

  @override
  List<Object> get props => [desk];
}

final class DeletedDesk extends DeskEvent {
  final Id id;

  const DeletedDesk({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

final class UpdatedCurrentDesk extends DeskEvent {
  final Desk currentDesk;

  const UpdatedCurrentDesk({
    required this.currentDesk,
  });

  @override
  List<Object> get props => [currentDesk];
}
