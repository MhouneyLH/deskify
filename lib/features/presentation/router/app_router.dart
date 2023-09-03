import 'package:deskify/features/presentation/subpages/subpages.dart';
import 'package:flutter/material.dart';

/// This class provides the routing of the subpages for the application.
///
/// The actual pages, which can be clicked in the BottomNavigationBar, are
/// defined in the [App] class.
class AppRouter {
  static const String homeStandingAnalyticsPath = '/home/standing_analytics';
  static const String homeSittingAnalyticsPath = '/home/sitting_analytics';
  static const String homeAddPresetPath = '/home/add_preset';
  static const String homeEditPresetPath = '/home/edit_preset';
  static const String homeMoveDeskPath = '/home/move_desk';
  static const String addDeskAddPresetPath = '/add_desk/add_preset';
  static const String addDeskEditPresetPath = '/add_desk/edit_preset';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //! HomePage
      case homeStandingAnalyticsPath:
        return MaterialPageRoute(builder: (_) => const AnalyticsPage());
      case homeSittingAnalyticsPath:
        return MaterialPageRoute(builder: (_) => const AnalyticsPage());
      case homeAddPresetPath:
        return MaterialPageRoute(builder: (_) => const PresetPage());
      case homeEditPresetPath:
        return MaterialPageRoute(builder: (_) => const PresetPage());
      case homeMoveDeskPath:
        return MaterialPageRoute(builder: (_) => const MoveDeskPage());
      //! AddDeskPage
      case addDeskAddPresetPath:
        return MaterialPageRoute(builder: (_) => const PresetPage());
      case addDeskEditPresetPath:
        return MaterialPageRoute(builder: (_) => const PresetPage());
      default:
        return null;
    }
  }
}
