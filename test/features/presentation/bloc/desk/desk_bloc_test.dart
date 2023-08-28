import 'package:dartz/dartz.dart';
import 'package:deskify/core/core.dart';
import 'package:deskify/features/data/models/desk_model.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/usecases/create_desk_usecase.dart';
import 'package:deskify/features/domain/usecases/delete_desk_usecase.dart';
import 'package:deskify/features/domain/usecases/get_all_desks_usecase.dart';
import 'package:deskify/features/domain/usecases/get_desk_by_id_usecase.dart';
import 'package:deskify/features/domain/usecases/update_desk_usecase.dart';
import 'package:deskify/features/presentation/bloc/desk/desk_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateDeskUsecase extends Mock implements CreateDeskUsecase {}

class MockGetAllDesksUsecase extends Mock implements GetAllDesksUsecase {}

class MockGetDeskByIdUsecase extends Mock implements GetDeskByIdUsecase {}

class MockUpdateDeskUsecase extends Mock implements UpdateDeskUsecase {}

class MockDeleteDeskUsecase extends Mock implements DeleteDeskUsecase {}

void main() {
  late DeskBloc sut;

  late MockCreateDeskUsecase mockCreateDeskUsecase;
  late MockGetAllDesksUsecase mockGetAllDesksUsecase;
  late MockGetDeskByIdUsecase mockGetDeskByIdUsecase;
  late MockUpdateDeskUsecase mockUpdateDeskUsecase;
  late MockDeleteDeskUsecase mockDeleteDeskUsecase;

  setUp(() {
    mockCreateDeskUsecase = MockCreateDeskUsecase();
    mockGetAllDesksUsecase = MockGetAllDesksUsecase();
    mockGetDeskByIdUsecase = MockGetDeskByIdUsecase();
    mockUpdateDeskUsecase = MockUpdateDeskUsecase();
    mockDeleteDeskUsecase = MockDeleteDeskUsecase();

    sut = DeskBloc(
      createDeskUsecase: mockCreateDeskUsecase,
      getAllDesksUsecase: mockGetAllDesksUsecase,
      getDeskByIdUsecase: mockGetDeskByIdUsecase,
      updateDeskUsecase: mockUpdateDeskUsecase,
      deleteDeskUsecase: mockDeleteDeskUsecase,
    );
  });

  const Id tDeskId = '0';
  final DeskModel tDeskModel = DeskModel(
    id: '0',
    name: 'test',
    height: 0.0,
    presets: const <Preset>[
      Preset(
        id: '0',
        name: 'test',
        targetHeight: 0.0,
      ),
      Preset(
        id: '1',
        name: 'test',
        targetHeight: 1.0,
      ),
    ],
  );

  setUpAll(() {
    registerFallbackValue(tDeskModel);

    registerFallbackValue(CreateDeskParams(desk: tDeskModel));
    registerFallbackValue(NoParams());
    registerFallbackValue(const GetDeskByIdParams(deskId: tDeskId));
    registerFallbackValue(UpdateDeskParams(desk: tDeskModel));
    registerFallbackValue(const DeleteDeskParams(deskId: tDeskId));
  });

  test('initialState should be Empty', () {
    // assert
    expect(sut.initialState, Empty());
  });

  group('CreateDeskUsecase', () {
    test(
      'should get nothing from the CreateDeskUsecase',
      () async {
        // arrange
        when(() => mockCreateDeskUsecase(any()))
            .thenAnswer((_) async => const Right(null));
        // act
        sut.add(CreatedDesk(desk: tDeskModel));
        await untilCalled(() => mockCreateDeskUsecase(any()));
        // assert
        verify(() => mockCreateDeskUsecase(CreateDeskParams(desk: tDeskModel)));
      },
    );

    test(
      'should emit [CreateDeskFetching, CreateDeskSuccess] when created successfully',
      () async {
        // arrange
        when(() => mockCreateDeskUsecase(any()))
            .thenAnswer((_) async => const Right(null));
        // assert
        final expected = [
          CreateDeskFetching(),
          CreateDeskSuccess(),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(CreatedDesk(desk: tDeskModel));
      },
    );

    test(
      'should emit [CreateDeskFetching, CreateDeskFailure] when creating fails',
      () async {
        // arrange
        when(() => mockCreateDeskUsecase(any()))
            .thenAnswer((_) async => Left(APIFailure()));
        // assert
        final expected = [
          CreateDeskFetching(),
          // TODO: maybe change this to a more specific error in the future
          const CreateDeskFailure(message: 'CreateDeskFailure'),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(CreatedDesk(desk: tDeskModel));
      },
    );
  });

  group('GetAllDesksUsecase', () {
    List<DeskModel> tDeskModelList = <DeskModel>[tDeskModel, tDeskModel];

    test(
      'should get data from the GetAllDesksUsecase',
      () async {
        // arrange
        when(() => mockGetAllDesksUsecase(any()))
            .thenAnswer((_) async => Right(tDeskModelList));
        // act
        sut.add(GotAllDesks());
        await untilCalled(() => mockGetAllDesksUsecase(any()));
        // assert
        verify(() => mockGetAllDesksUsecase(NoParams()));
      },
    );

    test(
      'should emit [GetAllDesksFetching, GetAllDesksSuccess] data is gotten successfully',
      () async {
        // arrange
        when(() => mockGetAllDesksUsecase(any()))
            .thenAnswer((_) async => Right(tDeskModelList));
        // assert
        final expected = [
          GetAllDesksFetching(),
          GetAllDesksSuccess(desks: tDeskModelList),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(GotAllDesks());
      },
    );

    test(
      'should emit [GetAllDesksFetching, GetAllDesksFailure] when getting data fails',
      () async {
        // arrange
        when(() => mockGetAllDesksUsecase(any()))
            .thenAnswer((_) async => Left(APIFailure()));
        // assert
        final expected = [
          GetAllDesksFetching(),
          const GetAllDesksFailure(message: 'GetAllDesksFailure'),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(GotAllDesks());
      },
    );
  });

  group('GetDeskByIdUsecase', () {
    test(
      'should get data from the GetDeskByIdUsecase',
      () async {
        // arrange
        when(() => mockGetDeskByIdUsecase(any()))
            .thenAnswer((_) async => Right(tDeskModel));
        // act
        sut.add(const GotDeskById(id: tDeskId));
        await untilCalled(() => mockGetDeskByIdUsecase(any()));
        // assert
        verify(() =>
            mockGetDeskByIdUsecase(const GetDeskByIdParams(deskId: tDeskId)));
      },
    );

    test(
      'should emit [GetDeskByIdFetching, GetDeskByIdSuccess] data is gotten successfully',
      () async {
        // arrange
        when(() => mockGetDeskByIdUsecase(any()))
            .thenAnswer((_) async => Right(tDeskModel));
        // assert
        final expected = [
          GetDeskByIdFetching(),
          GetDeskByIdSuccess(desk: tDeskModel),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(const GotDeskById(id: tDeskId));
      },
    );

    test(
      'should emit [GetDeskByIdFetching, GetDeskByIdFailure] when getting data fails',
      () async {
        // arrange
        when(() => mockGetDeskByIdUsecase(any()))
            .thenAnswer((_) async => Left(APIFailure()));
        // assert
        final expected = [
          GetDeskByIdFetching(),
          const GetDeskByIdFailure(message: 'GetDeskByIdFailure'),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(const GotDeskById(id: tDeskId));
      },
    );
  });

  group('UpdateDeskUsecase', () {
    test(
      'should get nothing from the UpdateDeskUsecase',
      () async {
        // arrange
        when(() => mockUpdateDeskUsecase(any()))
            .thenAnswer((_) async => const Right(null));
        // act
        sut.add(UpdatedDesk(desk: tDeskModel));
        await untilCalled(() => mockUpdateDeskUsecase(any()));
        // assert
        verify(() => mockUpdateDeskUsecase(UpdateDeskParams(desk: tDeskModel)));
      },
    );

    test(
      'should emit [UpdateDeskFetching, UpdateDeskSuccess] when created successfully',
      () async {
        // arrange
        when(() => mockUpdateDeskUsecase(any()))
            .thenAnswer((_) async => const Right(null));
        // assert
        final expected = [
          UpdateDeskFetching(),
          UpdateDeskSuccess(),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(UpdatedDesk(desk: tDeskModel));
      },
    );

    test(
      'should emit [UpdateDeskFetching, UpdateDeskFailure] when creating fails',
      () async {
        // arrange
        when(() => mockUpdateDeskUsecase(any()))
            .thenAnswer((_) async => Left(APIFailure()));
        // assert
        final expected = [
          UpdateDeskFetching(),
          const UpdateDeskFailure(message: 'UpdateDeskFailure'),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(UpdatedDesk(desk: tDeskModel));
      },
    );
  });

  group('DeleteDeskUsecase', () {
    test(
      'should get nothing from the DeleteDeskUsecase',
      () async {
        // arrange
        when(() => mockDeleteDeskUsecase(any()))
            .thenAnswer((_) async => const Right(null));
        // act
        sut.add(const DeletedDesk(id: tDeskId));
        await untilCalled(() => mockDeleteDeskUsecase(any()));
        // assert
        verify(() =>
            mockDeleteDeskUsecase(const DeleteDeskParams(deskId: tDeskId)));
      },
    );

    test(
      'should emit [DeleteDeskFetching, DeleteDeskSuccess] when created successfully',
      () async {
        // arrange
        when(() => mockDeleteDeskUsecase(any()))
            .thenAnswer((_) async => const Right(null));
        // assert
        final expected = [
          DeleteDeskFetching(),
          DeleteDeskSuccess(),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(const DeletedDesk(id: tDeskId));
      },
    );

    test(
      'should emit [DeleteDeskFetching, DeleteDeskFailure] when creating fails',
      () async {
        // arrange
        when(() => mockDeleteDeskUsecase(any()))
            .thenAnswer((_) async => Left(APIFailure()));
        // assert
        final expected = [
          DeleteDeskFetching(),
          const DeleteDeskFailure(message: 'DeleteDeskFailure'),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(const DeletedDesk(id: tDeskId));
      },
    );
  });

  group('updateCurrentDesk', () {
    // TODO: in future add more stuff in here -> for now, it only can be successful
    test(
      'should emit [UpdateCurrentDeskSuccess] when updated successfully',
      () async {
        // assert
        final expected = [
          UpdateCurrentDeskSuccess(currentDesk: tDeskModel),
        ];
        expectLater(sut.stream, emitsInOrder(expected));
        // act
        sut.add(UpdatedCurrentDesk(currentDesk: tDeskModel));
      },
    );
  });
}
