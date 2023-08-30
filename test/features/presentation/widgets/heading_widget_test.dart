import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home:  Heading(
        title: 'test',
      ),
    );
  }

  testWidgets('Heading is displayed', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    // assert
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('test'), findsOneWidget);
  });
}
