import 'package:deskify/features/presentation/pages/home_page/desk_interaction_card.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late bool onPressedCardCalled;
  late bool onPressedIconAtEndCalled;

  setUp(() {
    onPressedCardCalled = false;
    onPressedIconAtEndCalled = false;
  });

  group('default card', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: DeskInteractionCard(
          title: 'test',
          iconAtStart: const Icon(Icons.abc),
          onPressedCard: () {
            onPressedCardCalled = true;
          },
        ),
      );
    }

    testWidgets('''DeskInteractionCard is displayed with
                 * icon at the start
                 * title
                ''', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      // assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      await widgetTester.tap(find.byType(ElevatedButton));
      // assert
      expect(onPressedCardCalled, isTrue);
    });
  });

  group('card with child only', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: DeskInteractionCard(
          title: 'test',
          iconAtStart: const Icon(Icons.abc),
          onPressedCard: () {
            onPressedCardCalled = true;
          },
          child: const Text(
            'test',
            key: Key('child'),
          ),
        ),
      );
    }

    testWidgets('''DeskInteractionCard is displayed with
                 * icon at the start
                 * title
                 * child
                ''', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      // assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      // only here there are 2 Text widgets -> in future work with keys or something else
      expect(find.byType(Text), findsNWidgets(2));
      // idk why 4 -> 2 for the Text widgets and 2 for the SizedBox widgets (RenderConstraint Boxes for the texts)
      expect(find.byType(SizedBox), findsNWidgets(4));
      expect(find.byKey(const Key('child')), findsOneWidget);
      // expect(find.byType(CustomIconButton), findsNothing);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      await widgetTester.tap(find.byType(ElevatedButton));
      // assert
      expect(onPressedCardCalled, isTrue);
    });
  });

  group('card with icon at the end only', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: DeskInteractionCard(
          title: 'test',
          iconAtStart: const Icon(Icons.abc),
          onPressedCard: () {
            onPressedCardCalled = true;
          },
          iconAtEnd: const Icon(Icons.abc),
          onPressedIconAtEnd: () {
            onPressedIconAtEndCalled = true;
          },
        ),
      );
    }

    testWidgets('''DeskInteractionCard is displayed with
                 * icon at the start
                 * title
                 * icon at the end
                ''', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      // assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(2));
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Spacer), findsOneWidget);
      expect(find.byKey(const Key('child')), findsNothing);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      await widgetTester.tap(find.byType(ElevatedButton));
      // assert
      expect(onPressedCardCalled, isTrue);
    });

    testWidgets('onPressedIconAtEnd is executed on tap', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      await widgetTester.tap(find.byType(CustomIconButton));
      // assert
      expect(onPressedIconAtEndCalled, isTrue);
    });
  });

  group('card with child and icon at the end', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: DeskInteractionCard(
          title: 'test',
          iconAtStart: const Icon(Icons.abc),
          onPressedCard: () {
            onPressedCardCalled = true;
          },
          iconAtEnd: const Icon(Icons.abc),
          onPressedIconAtEnd: () {
            onPressedIconAtEndCalled = true;
          },
          child: const Text(
            'test',
            key: Key('child'),
          ),
        ),
      );
    }

    testWidgets('''DeskInteractionCard is displayed with
                 * icon at the start
                 * title
                 * icon at the end
                 * child
                ''', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      // assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(2));
      // only here there are 2 Text widgets -> in future work with keys or something else
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byKey(const Key('child')), findsOneWidget);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      await widgetTester.tap(find.byType(ElevatedButton));
      // assert
      expect(onPressedCardCalled, isTrue);
    });

    testWidgets('onPressedIconAtEnd is executed on tap', (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      // act
      await widgetTester.pumpWidget(widgetUnderTest);
      await widgetTester.tap(find.byType(CustomIconButton));
      // assert
      expect(onPressedIconAtEndCalled, isTrue);
    });
  });
}
