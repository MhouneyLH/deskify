import 'package:deskify/core/core.dart';
import 'package:deskify/features/domain/repository/desk_repository.dart';
import 'package:deskify/features/domain/usecases/usecases.dart';
import 'package:deskify/features/presentation/bloc/desk/desk_bloc.dart';
import 'package:deskify/features/presentation/pages/add_desk_page/add_desk_page.dart';
import 'package:deskify/features/presentation/router/app_router.dart';
import 'package:deskify/features/presentation/subpages/subpages.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeskRepository extends Mock implements DeskRepository {}

void main() {
  late MockDeskRepository mockDeskRepository;
  late AppRouter appRouter;

  setUp(() {
    mockDeskRepository = MockDeskRepository();
    appRouter = AppRouter();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider(
      create: (context) => DeskBloc(
        createDeskUsecase: CreateDeskUsecase(repository: mockDeskRepository),
        getAllDesksUsecase: GetAllDesksUsecase(repository: mockDeskRepository),
        getDeskByIdUsecase: GetDeskByIdUsecase(repository: mockDeskRepository),
        updateDeskUsecase: UpdateDeskUsecase(repository: mockDeskRepository),
        deleteDeskUsecase: DeleteDeskUsecase(repository: mockDeskRepository),
      ),
      child: MaterialApp(
        onGenerateRoute: (settings) => appRouter.onGenerateRoute(settings),
        home: const Scaffold(
          body: SingleChildScrollView(
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
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.enterText(
          find.byKey(const Key('desk-height-text-field')),
          deskMaximumHeight.toStringAsFixed(2));
      await widgetTester.pump();
      // assert
      final HeightSlider slider = widgetTester
          .widget<HeightSlider>(find.byKey(const Key('desk-height-slider')));

      expect(slider.deskHeight, deskMaximumHeight);
    });

    testWidgets(
        'Entering an invalid text (e. g. "," instead of ".") in the desk height TextField should change the value of the slider to deskMinimumHeight',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.enterText(
          find.byKey(const Key('desk-height-text-field')), '80,0');
      await widgetTester.pump();
      // assert
      final HeightSlider slider = widgetTester
          .widget<HeightSlider>(find.byKey(const Key('desk-height-slider')));

      expect(slider.deskHeight, deskMinimumHeight);
    });

    testWidgets(
        'Entering a too high text value (> deskHeightMaximum) in the desk height TextField should change the value of the slider to deskMaximumHeight',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.enterText(
          find.byKey(const Key('desk-height-text-field')),
          (deskMaximumHeight + 1).toStringAsFixed(2));
      await widgetTester.pump();
      // assert
      final HeightSlider slider = widgetTester
          .widget<HeightSlider>(find.byKey(const Key('desk-height-slider')));

      expect(slider.deskHeight, deskMaximumHeight);
    });

    testWidgets(
        'Entering a too low text value (< deskMinimumHeight) in the desk height TextField should change the value of the slider to deskMinimumHeight',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.enterText(
          find.byKey(const Key('desk-height-text-field')),
          (deskMinimumHeight - 1).toStringAsFixed(2));
      await widgetTester.pump();
      // assert
      final HeightSlider slider = widgetTester
          .widget<HeightSlider>(find.byKey(const Key('desk-height-slider')));

      expect(slider.deskHeight, deskMinimumHeight);
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

    testWidgets('List of Preset InteractionCards is displayed',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(InteractionCard), findsAtLeastNWidgets(2));
    });

    testWidgets(
        'Tapping on the icon at the end of an element of the Preset Interaction Card List, navigates to PresetPage',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      final InteractionCard addPresetButton = widgetTester
          .widget<InteractionCard>(find.byKey(const Key('preset-card-0')));

      // this is a workaround for the actual tap
      // the normal .tap() method does not work correctly as it seems
      // the tap cannot be executed, because the button is not visible, but actually it is...
      addPresetButton.onPressedIconAtEnd!();
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(PresetPage), findsOneWidget);
    });

    testWidgets('Add Preset button is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('add-preset-button')), findsOneWidget);
    });

    testWidgets('Tapping on the AddPresetButton, navigates to PresetPage',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      final IconButton addPresetButton = widgetTester
          .widget<IconButton>(find.byKey(const Key('add-preset-button')));

      // this is a workaround for the actual tap
      // the normal .tap() method does not work correctly as it seems
      // the tap cannot be executed, because the button is not visible, but actually it is...
      addPresetButton.onPressed!();
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(PresetPage), findsOneWidget);
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
