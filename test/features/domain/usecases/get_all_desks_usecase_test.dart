import 'package:dartz/dartz.dart';
import 'package:deskify/features/data/models/desk_model.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/desk/get_all_desks_usecase.dart';
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
  final List<DeskModel> tDeskModelList = <DeskModel>[tDeskModel, tDeskModel];

  test('should get all desk with no input from the repository', () async {
    // arrange
    when(() => mockDeskRepository.getAllDesks())
        .thenAnswer((_) async => Right(tDeskModelList));
    // act
    final result = await sut.repository.getAllDesks();
    // assert
    expect(result, Right(tDeskModelList));
    verify(() => mockDeskRepository.getAllDesks());
    verifyNoMoreInteractions(mockDeskRepository);
  });
}
