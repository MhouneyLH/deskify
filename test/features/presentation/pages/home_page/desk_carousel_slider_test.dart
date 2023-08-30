import 'package:carousel_slider/carousel_slider.dart';
import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:deskify/features/presentation/pages/home_page/desk_carousel_slider.dart';
import 'package:deskify/features/presentation/widgets/desk_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO: testing the onDeskSelected did not work -> hard to test because of the carousel slider
void main() {
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

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: DeskCarouselSlider(
        allDesks: deskList,
        onDeskSelected: (Desk desk) {},
      ),
    );
  }

  testWidgets('DeskCarouselSlider is displayed', (widgetTester) async {
    // arrange
    final Widget widgetUnderTest = createWidgetUnderTest();
    // act
    await widgetTester.pumpWidget(widgetUnderTest);
    // assert
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(DeskAnimation), findsNWidgets(deskList.length));
    expect(find.byType(Row), findsOneWidget);
  });
}
