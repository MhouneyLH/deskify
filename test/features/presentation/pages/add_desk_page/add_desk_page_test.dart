import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/usecases.dart';
import 'package:deskify/features/presentation/bloc/desk/desk_bloc.dart';
import 'package:deskify/features/presentation/pages/add_desk_page/add_desk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeskRepository extends Mock implements DeskRepository {}

void main() {
  late MockDeskRepository mockDeskRepository;

  setUp(() {
    mockDeskRepository = MockDeskRepository();
  });

  final Desk desk = Desk(
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

  void arrangeDeskRepositoryCreateDesk() {
    when(() => mockDeskRepository.createDesk(desk))
        .thenAnswer((_) async => const Right(null));
  }

  void arrangeDeskRepositoryCreateDeskAfter2SecondsWait() {
    when(() => mockDeskRepository.createDesk(desk)).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return const Right(null);
    });
  }

  Widget createWidgetUnderTest() {
    return BlocProvider(
      create: (context) => DeskBloc(
        createDeskUsecase: CreateDeskUsecase(repository: mockDeskRepository),
        getAllDesksUsecase: GetAllDesksUsecase(repository: mockDeskRepository),
        getDeskByIdUsecase: GetDeskByIdUsecase(repository: mockDeskRepository),
        updateDeskUsecase: UpdateDeskUsecase(repository: mockDeskRepository),
        deleteDeskUsecase: DeleteDeskUsecase(repository: mockDeskRepository),
      ),
      child: const MaterialApp(
        home: SingleChildScrollView(
          // TODO: idk, why this material here is needed -> otherwise it does not work correctly
          child: Material(
            child: AddDeskPage(),
          ),
        ),
      ),
    );
  }

  group('General', () {
    testWidgets('Heading is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('general-heading')), findsOneWidget);
    });

    testWidgets('Text field for desk name is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('desk-name-text-field')), findsOneWidget);
    });

    testWidgets('Text field for desk height is displayed',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('desk-height-text-field')), findsOneWidget);
    });

    testWidgets('DeskAnimation is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('desk-animation')), findsOneWidget);
    });

    testWidgets('HeightSlider is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('desk-height-slider')), findsOneWidget);
    });
  });

  group('Presets', () {
    testWidgets('Heading is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('presets-heading')), findsOneWidget);
    });
  });
}
