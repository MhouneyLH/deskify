import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/delete_desk_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeskRepository extends Mock implements DeskRepository {}

void main() {
  late DeleteDeskUsecase sut;
  late MockDeskRepository mockDeskRepository;

  setUp(() {
    mockDeskRepository = MockDeskRepository();
    sut = DeleteDeskUsecase(repository: mockDeskRepository);
  });

  const String tDeskid = '0';

  test('should delete a desk for the Id from the repository', () async {
    // arrange
    when(() => mockDeskRepository.deleteDesk(any()))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await sut.repository.deleteDesk(tDeskid);
    // assert
    expect(result, const Right(null));
    verify(() => mockDeskRepository.deleteDesk(tDeskid));
    verifyNoMoreInteractions(mockDeskRepository);
  });
}
