import 'package:dartz/dartz.dart';
import 'package:deskify/features/data/models/desk_model.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/desk/create_desk_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeskRepository extends Mock implements DeskRepository {}

void main() {
  late CreateDeskUsecase sut;
  late MockDeskRepository mockDeskRepository;

  setUp(() {
    mockDeskRepository = MockDeskRepository();
    sut = CreateDeskUsecase(repository: mockDeskRepository);
  });

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

  test('should create the desk with the model from the repository', () async {
    // arrange
    when(() => mockDeskRepository.createDesk(any()))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await sut.repository.createDesk(tDeskModel);
    // assert
    expect(result, const Right(null));
    verify(() => mockDeskRepository.createDesk(tDeskModel));
    verifyNoMoreInteractions(mockDeskRepository);
  });
}
