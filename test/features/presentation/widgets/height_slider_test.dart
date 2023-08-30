import 'package:deskify/core/core.dart';
import 'package:deskify/features/presentation/widgets/height_slider.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: HeightSlider(
        deskHeight: deskMinimumHeight,
        onChanged: (double height) {},
        onChangeEnd: (double height) {},
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
}
