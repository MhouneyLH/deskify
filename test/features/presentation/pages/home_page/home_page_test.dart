import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/create_desk_usecase.dart';
import 'package:deskify/features/domain/usecases/delete_desk_usecase.dart';
import 'package:deskify/features/domain/usecases/get_all_desks_usecase.dart';
import 'package:deskify/features/domain/usecases/get_desk_by_id_usecase.dart';
import 'package:deskify/features/domain/usecases/update_desk_usecase.dart';
import 'package:deskify/features/presentation/bloc/desk/desk_bloc.dart';
import 'package:deskify/features/presentation/pages/home_page/desk_carousel_slider.dart';
import 'package:deskify/features/presentation/pages/home_page/desk_interaction_card.dart';
import 'package:deskify/features/presentation/pages/home_page/home_page.dart';
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

  final List<Desk> deskList = <Desk>[
    desk,
    desk,
  ];

  void arrangeDeskRepositoryReturns2Desks() {
    when(() => mockDeskRepository.getAllDesks())
        .thenAnswer((_) async => Right(deskList));
  }

  void arrangeDeskRepositoryReturns2DesksAfter2SecondsWait() {
    when(() => mockDeskRepository.getAllDesks()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Right(deskList);
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
          child: HomePage(),
        ),
      ),
    );
  }

  testWidgets(
    'Loading indicator is displayed while fetching all desks',
    (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2DesksAfter2SecondsWait();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));
      // assert
      expect(find.byKey(const Key('all-articles-loading-indicator')),
          findsOneWidget);
      await widgetTester.pumpAndSettle();
    },
  );

  testWidgets(
    'DeskCarouselSlider is displayed after fetching all desks and is filled with the desks',
    (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(DeskCarouselSlider), findsOneWidget);
      expect(
        (widgetTester.widget(find.byType(DeskCarouselSlider))
                as DeskCarouselSlider)
            .allDesks,
        equals(deskList),
      );
    },
  );

  testWidgets(
      'Current Desk name and current desk height are displayed when desks are available',
      (widgetTester) async {
    // arrange
    arrangeDeskRepositoryReturns2Desks();
    // act
    await widgetTester.pumpWidget(createWidgetUnderTest());
    await widgetTester.pumpAndSettle();
    // assert
    expect(find.byKey(const Key('current-desk-name')), findsOneWidget);
    expect(find.byKey(const Key('current-desk-height')), findsOneWidget);
  });

  group('Analytics', () {
    testWidgets('Heading is displayed', (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('analytics-heading')), findsOneWidget);
    });

    testWidgets('2 DeskInteractionCards are be displayed',
        (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('analytics-desk-card-standing')),
          findsOneWidget);
      expect(
          find.byKey(const Key('analytics-desk-card-sitting')), findsOneWidget);

      final DeskInteractionCard analyticsDeskCardStanding =
          widgetTester.firstWidget(
                  find.byKey(const Key('analytics-desk-card-standing')))
              as DeskInteractionCard;
      final DeskInteractionCard analyticsDeskCardSitting = widgetTester
              .firstWidget(find.byKey(const Key('analytics-desk-card-sitting')))
          as DeskInteractionCard;

      expect(analyticsDeskCardStanding.child, isA<LinearProgressIndicator>());
      expect(analyticsDeskCardSitting.child, isA<LinearProgressIndicator>());

      expect(analyticsDeskCardStanding.iconAtEnd, isNull);
      expect(analyticsDeskCardSitting.iconAtEnd, isNull);
    });
  });

  group('Presets', () {
    testWidgets('Heading is displayed', (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('preset-heading')), findsOneWidget);
    });

    testWidgets('2 DeskInteractionCards are displayed', (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('preset-desk-card-0')), findsOneWidget);
      expect(find.byKey(const Key('preset-desk-card-1')), findsOneWidget);

      final DeskInteractionCard presetCard0 =
          widgetTester.firstWidget(find.byKey(const Key('preset-desk-card-0')))
              as DeskInteractionCard;

      final DeskInteractionCard presetCard1 =
          widgetTester.firstWidget(find.byKey(const Key('preset-desk-card-1')))
              as DeskInteractionCard;

      expect(presetCard0.child, isA<Text>());
      expect(presetCard1.child, isA<Text>());

      expect(presetCard0.iconAtEnd, isA<Icon>());
      expect(presetCard1.iconAtEnd, isA<Icon>());
    });
  });

  group('Others', () {
    testWidgets('Heading is displayed', (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('others-heading')), findsOneWidget);
    });

    testWidgets('1 DeskInteractionCard for others is displayed',
        (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('others-desk-card-move')), findsOneWidget);

      final DeskInteractionCard othersCardMove = widgetTester
              .firstWidget(find.byKey(const Key('others-desk-card-move')))
          as DeskInteractionCard;

      expect(othersCardMove.child, isNull);
      expect(othersCardMove.iconAtEnd, isNull);
    });
  });
}
