import 'package:deskify/core/core.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int partsOfDesk = 3;

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: DeskAnimation(
        width: 200,
        deskHeight: deskMinimumHeight,
      ),
    );
  }

  testWidgets('DeskAnimation is displayed', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    // assert
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Positioned), findsNWidgets(partsOfDesk));
    expect(find.byType(Container), findsNWidgets(partsOfDesk));
  });

  testWidgets('DeskAnimation has correct color', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    final BuildContext context = widgetTester.element(find.byType(MaterialApp));
    // assert
    final containerList = widgetTester.widgetList(find.byType(Container));
    for (final elem in containerList) {
      expect(
        (((elem as Container).decoration) as BoxDecoration).color,
        Theme.of(context).colorScheme.tertiary,
      );
    }
  });
}
