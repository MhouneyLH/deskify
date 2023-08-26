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

const String apiFailureMessage = 'API Failure';
const String unexpectedFailureMessage = 'Unexpected error';

class DeskBloc extends Bloc<DeskEvent, DeskState> {
  final CreateDeskUsecase createDeskUsecase;
  final GetAllDesksUsecase getAllDesksUsecase;
  final GetDeskByIdUsecase getDeskByIdUsecase;
  final UpdateDeskUsecase updateDeskUsecase;
  final DeleteDeskUsecase deleteDeskUsecase;

  DeskBloc(
    this.createDeskUsecase,
    this.getAllDesksUsecase,
    this.getDeskByIdUsecase,
    this.updateDeskUsecase,
    this.deleteDeskUsecase,
  ) : super(Empty()) {
    on<CreatedDesk>(onCreatedDesk);
    on<GotAllDesks>(onGotAllDesks);
    on<GotDeskById>(onGotDeskById);
    on<UpdatedDesk>(onUpdatedDesk);
    on<DeletedDesk>(onDeletedDesk);
  }

  void onCreatedDesk(CreatedDesk event, Emitter<DeskState> emit) async {
    emit(Loading());

    final failureOrVoid = await createDeskUsecase(
      CreateDeskParams(desk: event.desk),
    );

    failureOrVoid.fold(
      (failure) => emit(const CreateDeskFailure(message: 'CreateDeskFailure')),
      (success) => emit(CreateDeskSuccess()),
    );
  }

  void onGotAllDesks(GotAllDesks event, Emitter<DeskState> emit) async {
    emit(Loading());

    final failureOrDesks = await getAllDesksUsecase(
      GetAllDesksParams(),
    );

    failureOrDesks.fold(
      (failure) =>
          emit(const GetAllDesksFailure(message: 'GetAllDesksFailure')),
      (success) => emit(GetAllDesksSuccess(desks: success)),
    );
  }

  void onGotDeskById(GotDeskById event, Emitter<DeskState> emit) async {
    emit(Loading());

    final failureOrDesk = await getDeskByIdUsecase(
      GetDeskByIdParams(deskId: event.id),
    );

    failureOrDesk.fold(
      (failure) =>
          emit(const GetDeskByIdFailure(message: 'GetDeskByIdFailure')),
      (success) => emit(GetDeskByIdSuccess(desk: success)),
    );
  }

  void onUpdatedDesk(UpdatedDesk event, Emitter<DeskState> emit) async {
    emit(Loading());

    final failureOrVoid = await updateDeskUsecase(
      UpdateDeskParams(desk: event.desk),
    );

    failureOrVoid.fold(
      (failure) => emit(const UpdateDeskFailure(message: 'UpdateDeskFailure')),
      (success) => emit(UpdateDeskSuccess()),
    );
  }

  void onDeletedDesk(DeletedDesk event, Emitter<DeskState> emit) async {
    emit(Loading());

    final failureOrVoid = await deleteDeskUsecase(
      DeleteDeskParams(deskId: event.id),
    );

    failureOrVoid.fold(
      (failure) => emit(const DeleteDeskFailure(message: 'DeleteDeskFailure')),
      (success) => emit(DeleteDeskSuccess()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case APIFailure:
        return apiFailureMessage;
      default:
        return unexpectedFailureMessage;
    }
  }
}
