import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late bool onPressedCalled;

  setUp(() {
    onPressedCalled = false;
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: CustomIconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          onPressedCalled = true;
        },
      ),
    );
  }

  testWidgets('CustomIconButton is displayed', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    // assert
    expect(
      (widgetTester.widget(find.byType(Material)) as Material).color,
      Colors.transparent,
    );
    expect(find.byType(InkWell), findsOneWidget);
  });

  testWidgets('onPressed is executed on tap', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.tap(find.byType(InkWell));
    // assert
    expect(onPressedCalled, isTrue);
  });
}
