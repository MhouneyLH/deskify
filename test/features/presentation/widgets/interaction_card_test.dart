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

  group('card without child or icon at the end', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: InteractionCard(
            title: 'title',
            iconAtStart: const Icon(
              Icons.abc,
              key: Key('icon-at-start'),
            ),
            onPressedCard: () {
              onPressedCardCalled = true;
            },
          ),
        ),
      );
    }

    testWidgets('The InteractionCard is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('The InteractionCard has an icon at the start',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('icon-at-start')), findsOneWidget);
    });

    testWidgets('The InteractionCard has a title', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.tap(find.byType(Card));
      // assert
      expect(onPressedCardCalled, isTrue);
    });
  });

  group('card without child but with icon at the end', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: InteractionCard(
            title: 'title',
            iconAtStart: const Icon(
              Icons.abc,
              key: Key('icon-at-start'),
            ),
            iconAtEnd: const Icon(
              Icons.abc,
              key: Key('icon-at-end'),
            ),
            onPressedCard: () {
              onPressedCardCalled = true;
            },
            onPressedIconAtEnd: () {
              onPressedIconAtEndCalled = true;
            },
          ),
        ),
      );
    }

    testWidgets('The InteractionCard is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('The InteractionCard has an icon at the start',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('icon-at-start')), findsOneWidget);
    });

    testWidgets('The InteractionCard has a title', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('The InteractionCard has an icon at the end',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('icon-at-end')), findsOneWidget);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.tap(find.byType(Card));
      // assert
      expect(onPressedCardCalled, isTrue);
    });

    testWidgets('onPressedIconAtEnd is executed on tap', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.tap(find.byKey(const Key('icon-at-end')));
      // assert
      expect(onPressedIconAtEndCalled, isTrue);
    });

    testWidgets('child is not displayed', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('child')), findsNothing);
    });
  });

  group('card with child but without icon at the end', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: InteractionCard(
            title: 'title',
            iconAtStart: const Icon(Icons.abc),
            onPressedCard: () {
              onPressedCardCalled = true;
            },
            child: const Text(
              'child',
              key: Key('child'),
            ),
          ),
        ),
      );
    }

    testWidgets('The InteractionCard is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('The InteractionCard has an icon at the start',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('The InteractionCard has a title', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.tap(find.byType(Card));
      // assert
      expect(onPressedCardCalled, isTrue);
    });

    testWidgets('child is displayed', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('child')), findsOneWidget);
    });

    testWidgets('icon at the end is not displayed', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('icon-at-end')), findsNothing);
    });
  });

  group('card with child and icon at the end', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: InteractionCard(
            title: 'title',
            iconAtStart: const Icon(
              Icons.abc,
              key: Key('icon-at-start'),
            ),
            iconAtEnd: const Icon(
              Icons.abc,
              key: Key('icon-at-end'),
            ),
            onPressedCard: () {
              onPressedCardCalled = true;
            },
            onPressedIconAtEnd: () {
              onPressedIconAtEndCalled = true;
            },
            child: const Text(
              'child',
              key: Key('child'),
            ),
          ),
        ),
      );
    }

    testWidgets('The InteractionCard is displayed', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('The InteractionCard has an icon at the start',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('icon-at-start')), findsOneWidget);
    });

    testWidgets('The InteractionCard has a title', (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('The InteractionCard has an icon at the end',
        (widgetTester) async {
      // act
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('icon-at-end')), findsOneWidget);
    });

    testWidgets('onPressedCard is executed on tap', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.tap(find.byType(Card));
      // assert
      expect(onPressedCardCalled, isTrue);
    });

    testWidgets('onPressedIconAtEnd is executed on tap', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // act
      await widgetTester.tap(find.byKey(const Key('icon-at-end')));
      // assert
      expect(onPressedIconAtEndCalled, isTrue);
    });

    testWidgets('child is displayed', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // assert
      expect(find.byKey(const Key('child')), findsOneWidget);
    });
  });
}
