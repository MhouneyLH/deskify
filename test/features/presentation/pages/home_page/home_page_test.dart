import 'package:dartz/dartz.dart';
import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/usecases.dart';
import 'package:deskify/features/presentation/bloc/desk/desk_bloc.dart';
import 'package:deskify/features/presentation/pages/home_page/desk_carousel_slider.dart';
import 'package:deskify/features/presentation/pages/home_page/home_page.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
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
      expect(
          find.byKey(const Key('all-desks-loading-indicator')), findsOneWidget);
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

    testWidgets('2 InteractionCards are be displayed', (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      final InteractionCard analyticsDeskCardStanding =
          widgetTester.firstWidget(
                  find.byKey(const Key('analytics-desk-card-standing')))
              as InteractionCard;
      final InteractionCard analyticsDeskCardSitting = widgetTester
              .firstWidget(find.byKey(const Key('analytics-desk-card-sitting')))
          as InteractionCard;

      expect(find.byKey(const Key('analytics-desk-card-standing')),
          findsOneWidget);
      expect(
          find.byKey(const Key('analytics-desk-card-sitting')), findsOneWidget);

      expect(analyticsDeskCardStanding.child, isA<LinearProgressIndicator>());
      expect(analyticsDeskCardSitting.child, isA<LinearProgressIndicator>());

      expect(analyticsDeskCardStanding.subtitle, isNull);
      expect(analyticsDeskCardSitting.subtitle, isNull);
      
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

    testWidgets('2 InteractionCards are displayed', (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      final InteractionCard presetCard0 =
          widgetTester.firstWidget(find.byKey(const Key('preset-desk-card-0')))
              as InteractionCard;
      final InteractionCard presetCard1 =
          widgetTester.firstWidget(find.byKey(const Key('preset-desk-card-1')))
              as InteractionCard;

      expect(find.byKey(const Key('preset-desk-card-0')), findsOneWidget);
      expect(find.byKey(const Key('preset-desk-card-1')), findsOneWidget);

      expect(presetCard0.subtitle, isNotNull);
      expect(presetCard1.subtitle, isNotNull);

      expect(presetCard0.child, isNull);
      expect(presetCard1.child, isNull);

      expect(presetCard0.iconAtEnd, isNotNull);
      expect(presetCard1.iconAtEnd, isNotNull);
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

    testWidgets('1 InteractionCard for others is displayed',
        (widgetTester) async {
      // arrange
      arrangeDeskRepositoryReturns2Desks();
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // assert
      final InteractionCard othersCardMove = widgetTester.firstWidget(
          find.byKey(const Key('others-desk-card-move'))) as InteractionCard;

      expect(find.byKey(const Key('others-desk-card-move')), findsOneWidget);

      expect(othersCardMove.subtitle, isNull);
      expect(othersCardMove.child, isNull);
      expect(othersCardMove.iconAtEnd, isNull);
    });
  });
}
