import 'package:deskify/core/core.dart';
import 'package:deskify/features/presentation/widgets/height_slider.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() {
  late double tHeight;

  setUp(() {
    tHeight = deskMinimumHeight;
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: HeightSlider(
        deskHeight: deskMinimumHeight,
        onChanged: (double height) {
          tHeight = height;
        },
        onChangeEnd: (double height) {
          tHeight = height;
        },
      ),
    );
  }

  testWidgets('HeightSlider is displayed', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    // assert
    expect(find.byType(SfSlider), findsOneWidget);
  });

  testWidgets(
    'Changing the value of the slider, calls the onChanged callback',
    (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      await widgetTester.pumpWidget(widgetUnderTest);
      // act
      await widgetTester.drag(
        find.byType(SfSlider),
        const Offset(0, -100),
      );
      await widgetTester.pump();
      // assert
      expect(tHeight, isNot(deskMinimumHeight));
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'Changing the value of the slider, calls the onChangeEnd callback',
    (widgetTester) async {
      // arrange
      final Widget widgetUnderTest = createWidgetUnderTest();
      await widgetTester.pumpWidget(widgetUnderTest);
      // act
      await widgetTester.drag(
        find.byType(SfSlider),
        const Offset(0, -100),
      );
      await widgetTester.pump();
      // assert
      expect(tHeight, isNot(deskMinimumHeight));
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    },
  );
}
