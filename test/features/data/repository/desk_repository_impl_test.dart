import 'package:dartz/dartz.dart';
import 'package:deskify/core/core.dart';
import 'package:deskify/features/data/data_sources/desk_remote_data_source.dart';
import 'package:deskify/features/data/models/desk_model.dart';
import 'package:deskify/features/data/repository/desk_repository_impl.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeskRemoteDataSource extends Mock implements DeskRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late DeskRepository sut;

  late MockDeskRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

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
  });

  setUp(() {
    mockRemoteDataSource = MockDeskRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    sut = DeskRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('createDesk', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.createDesk(any()))
            .thenAnswer((_) async => {});
        // act
        sut.createDesk(tDeskModel);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return Right(null) when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.createDesk(any()))
              .thenAnswer((_) async => const Right(null));
          // act
          final result = await sut.createDesk(tDeskModel);
          // assert
          expect(result, const Right(null));
        },
      );

      test(
        'should return Left(APIFailure()) when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.createDesk(any()))
              .thenThrow(APIException(message: 'test'));
          // act
          final result = await sut.createDesk(tDeskModel);
          // assert
          expect(result, Left(APIFailure()));
        },
      );
    });
  });

  group('getAllDesks', () {
    List<DeskModel> tDeskModelList = [
      tDeskModel,
      tDeskModel,
    ];

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getAllDesks())
            .thenAnswer((_) async => tDeskModelList);
        // act
        sut.getAllDesks();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return Right(null) when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getAllDesks())
              .thenAnswer((_) async => tDeskModelList);
          // act
          final result = await sut.getAllDesks();
          // assert
          expect(result, equals(Right(tDeskModelList)));
        },
      );

      test(
        'should return Left(APIFailure()) when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getAllDesks())
              .thenThrow(APIException(message: 'test'));
          // act
          final result = await sut.getAllDesks();
          // assert
          expect(result, Left(APIFailure()));
        },
      );
    });
  });

  group('getDeskById', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getDeskById(any()))
            .thenAnswer((_) async => tDeskModel);
        // act
        sut.getDeskById(tDeskId);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return Right(null) when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getDeskById(any()))
              .thenAnswer((_) async => tDeskModel);
          // act
          final result = await sut.getDeskById(tDeskId);
          // assert
          expect(result, equals(Right(tDeskModel)));
        },
      );

      test(
        'should return Left(APIFailure()) when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getDeskById(any()))
              .thenThrow(APIException(message: 'test'));
          // act
          final result = await sut.getDeskById(tDeskId);
          // assert
          expect(result, Left(APIFailure()));
        },
      );
    });
  });

  group('updateDesk', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.updateDesk(any()))
            .thenAnswer((_) async => {});
        // act
        sut.updateDesk(tDeskModel);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return Right(null) when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.updateDesk(any()))
              .thenAnswer((_) async => const Right(null));
          // act
          final result = await sut.updateDesk(tDeskModel);
          // assert
          expect(result, const Right(null));
        },
      );

      test(
        'should return Left(APIFailure()) when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.updateDesk(any()))
              .thenThrow(APIException(message: 'test'));
          // act
          final result = await sut.updateDesk(tDeskModel);
          // assert
          expect(result, Left(APIFailure()));
        },
      );
    });
  });

  group('deleteDesk', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.createDesk(any()))
            .thenAnswer((_) async => tDeskModel);
        // act
        sut.createDesk(tDeskModel);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return Right(null) when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.deleteDesk(any()))
              .thenAnswer((_) async => const Right(null));
          // act
          final result = await sut.deleteDesk(tDeskId);
          // assert
          expect(result, const Right(null));
        },
      );

      test(
        'should return Left(APIFailure()) when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.deleteDesk(any()))
              .thenThrow(APIException(message: 'test'));
          // act
          final result = await sut.deleteDesk(tDeskId);
          // assert
          expect(result, Left(APIFailure()));
        },
      );
    });
  });
}
