import 'package:dartz/dartz.dart';
import 'package:deskify/core/core.dart';
import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/usecases.dart';
import 'package:deskify/features/presentation/bloc/desk/desk_bloc.dart';
import 'package:deskify/features/presentation/pages/add_desk_page/add_desk_page.dart';
import 'package:deskify/features/presentation/pages/add_desk_page/preset_card.dart';
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

  final Desk tDesk = Desk(
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

    testWidgets(
        'Entering text in the desk height TextField changes the value of the slider',
        (widgetTester) async {
      // TODO: TEST
    });

    testWidgets(
        'Changing the value of the slider, changes the value of the desk height TextField',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.drag(
          find.byKey(const Key('desk-height-slider')), const Offset(0, -50));
      await widgetTester.pump();
      // assert
      final TextField textField = widgetTester
          .widget<TextField>(find.byKey(const Key('desk-height-text-field')));
      final HeightSlider heightSlider = widgetTester
          .widget<HeightSlider>(find.byKey(const Key('desk-height-slider')));

      expect(textField.controller!.text,
          heightSlider.deskHeight.toStringAsFixed(2));
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    });
  });

  group('Presets', () {
    testWidgets('Heading is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('presets-heading')), findsOneWidget);
    });

    testWidgets('List of Preset Cards is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(PresetCard), findsAtLeastNWidgets(2));
    });

    testWidgets('Add Preset button is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('add-preset-button')), findsOneWidget);
    });
  });

  testWidgets('Add Desk button is displayed', (widgetTester) async {
    // act
    await widgetTester.pumpWidget(createWidgetUnderTest());
    // assert
    expect(find.byKey(const Key('add-desk-button')), findsOneWidget);
  });

  testWidgets(
      'After tapping the add desk button, the input of the desk name, the desk height and the presets are cleared',
      (widgetTester) async {
    // TODO: TEST
  });
}
