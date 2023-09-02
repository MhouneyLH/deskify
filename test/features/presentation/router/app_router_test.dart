import 'package:deskify/features/presentation/router/app_router.dart';
import 'package:deskify/features/presentation/subpages/subpages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppRouter appRouter;

  setUp(() {
    appRouter = AppRouter();
  });

  const String tUnknownRouteName = 'unknown';

  Widget createWidgetUnderTest() {
    return MaterialApp(
      onGenerateRoute: (settings) => appRouter.onGenerateRoute(settings),
      home: Scaffold(
        body: Container(),
      ),
    );
  }

  group('onGenerateRoute', () {
    testWidgets('returns null for unknown route', (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      final Route? route = appRouter.onGenerateRoute(
        const RouteSettings(name: tUnknownRouteName),
      );
      // assert
      expect(route, null);
    });

    testWidgets('returns the correct route for homeStandingAnalyticsPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.homeStandingAnalyticsPath);
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(AnalyticsPage), findsOneWidget);
    });

    testWidgets('returns the correct route for homeSittingAnalyticsPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.homeSittingAnalyticsPath);
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(AnalyticsPage), findsOneWidget);
    });

    testWidgets('returns the correct route for homeAddPresetPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.homeAddPresetPath);
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(PresetPage), findsOneWidget);
    });

    testWidgets('returns the correct route for homeEditPresetPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.homeEditPresetPath);
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(PresetPage), findsOneWidget);
    });

    testWidgets('returns the correct route for homeMoveDeskPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.homeMoveDeskPath);
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(MoveDeskPage), findsOneWidget);
    });

    testWidgets('returns the correct route for addDeskAddPresetPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.addDeskAddPresetPath);
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(PresetPage), findsOneWidget);
    });

    testWidgets('returns the correct route for addDeskEditPresetPath',
        (widgetTester) async {
      // arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();
      // act
      // the context is needed from the scaffold to navigate
      final BuildContext context = widgetTester.element(find.byType(Scaffold));
      Navigator.of(context).pushNamed(AppRouter.addDeskEditPresetPath);

      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byType(PresetPage), findsOneWidget);
    });
  });
}
