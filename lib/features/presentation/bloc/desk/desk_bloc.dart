// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/desk.dart';
import '../../../domain/usecases/create_desk_usecase.dart';
import '../../../domain/usecases/delete_desk_usecase.dart';
import '../../../domain/usecases/get_all_desks_usecase.dart';
import '../../../domain/usecases/get_desk_by_id_usecase.dart';
import '../../../domain/usecases/update_desk_usecase.dart';

part 'desk_event.dart';
part 'desk_state.dart';

class DeskBloc extends Bloc<DeskEvent, DeskState> {
  Desk currentDesk = Desk.empty();

  final CreateDeskUsecase createDeskUsecase;
  final GetAllDesksUsecase getAllDesksUsecase;
  final GetDeskByIdUsecase getDeskByIdUsecase;
  final UpdateDeskUsecase updateDeskUsecase;
  final DeleteDeskUsecase deleteDeskUsecase;

  DeskBloc({
    required this.createDeskUsecase,
    required this.getAllDesksUsecase,
    required this.getDeskByIdUsecase,
    required this.updateDeskUsecase,
    required this.deleteDeskUsecase,
  }) : super(Empty()) {
    on<CreatedDesk>(onCreatedDesk);
    on<GotAllDesks>(onGotAllDesks);
    on<GotDeskById>(onGotDeskById);
    on<UpdatedDesk>(onUpdatedDesk);
    on<DeletedDesk>(onDeletedDesk);
    on<UpdatedCurrentDesk>(onUpdatedCurrentDesk);
  }

  void onCreatedDesk(DeskEvent event, Emitter<DeskState> emit) async {
    if (event is CreatedDesk) {
      emit(CreateDeskFetching());

      final failureOrVoid = await createDeskUsecase(
        CreateDeskParams(desk: event.desk),
      );

      failureOrVoid.fold(
        (failure) =>
            emit(const CreateDeskFailure(message: 'CreateDeskFailure')),
        (success) => emit(CreateDeskSuccess()),
      );
    }
  }

  void onGotAllDesks(DeskEvent event, Emitter<DeskState> emit) async {
    if (event is GotAllDesks) {
      emit(GetAllDesksFetching());

      final failureOrDesks = await getAllDesksUsecase(
        GetAllDesksParams(),
      );

      failureOrDesks.fold(
        (failure) =>
            emit(const GetAllDesksFailure(message: 'GetAllDesksFailure')),
        (success) => emit(GetAllDesksSuccess(desks: success)),
      );
    }
  }

  void onGotDeskById(DeskEvent event, Emitter<DeskState> emit) async {
    if (event is GotDeskById) {
      emit(GetDeskByIdFetching());

      final failureOrDesk = await getDeskByIdUsecase(
        GetDeskByIdParams(deskId: event.id),
      );

      failureOrDesk.fold(
        (failure) =>
            emit(const GetDeskByIdFailure(message: 'GetDeskByIdFailure')),
        (success) => emit(GetDeskByIdSuccess(desk: success)),
      );
    }
  }

  void onUpdatedDesk(DeskEvent event, Emitter<DeskState> emit) async {
    if (event is UpdatedDesk) {
      emit(UpdateDeskFetching());

      final failureOrVoid = await updateDeskUsecase(
        UpdateDeskParams(desk: event.desk),
      );

      failureOrVoid.fold(
        (failure) =>
            emit(const UpdateDeskFailure(message: 'UpdateDeskFailure')),
        (success) => emit(UpdateDeskSuccess()),
      );
    }
  }

  void onDeletedDesk(DeskEvent event, Emitter<DeskState> emit) async {
    if (event is DeletedDesk) {
      emit(DeleteDeskFetching());

      final failureOrVoid = await deleteDeskUsecase(
        DeleteDeskParams(deskId: event.id),
      );

      failureOrVoid.fold(
        (failure) =>
            emit(const DeleteDeskFailure(message: 'DeleteDeskFailure')),
        (success) => emit(DeleteDeskSuccess()),
      );
    }
  }

  void onUpdatedCurrentDesk(
    DeskEvent event,
    Emitter<DeskState> emit,
  ) async {
    if (event is UpdatedCurrentDesk) {
      currentDesk = event.currentDesk;

      // should only be successful
      emit(UpdateCurrentDeskSuccess(
        currentDesk: event.currentDesk,
      ));
    }
  }
}
