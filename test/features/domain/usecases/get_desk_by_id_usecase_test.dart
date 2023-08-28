import 'package:dartz/dartz.dart';
import 'package:deskify/features/data/models/desk_model.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/get_all_desks_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeskRepository extends Mock implements DeskRepository {}

void main() {
  late GetAllDesksUsecase sut;
  late MockDeskRepository mockDeskRepository;

  setUp(() {
    mockDeskRepository = MockDeskRepository();
    sut = GetAllDesksUsecase(repository: mockDeskRepository);
  });

  const String tDeskid = '0';
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

  test('should get a specific desk with the Id from the repository', () async {
    // arrange
    when(() => mockDeskRepository.getDeskById(tDeskid))
        .thenAnswer((_) async => Right(tDeskModel));
    // act
    final result = await sut.repository.getDeskById(tDeskid);
    // assert
    expect(result, Right(tDeskModel));
    verify(() => mockDeskRepository.getDeskById(tDeskid));
    verifyNoMoreInteractions(mockDeskRepository);
  });
}
