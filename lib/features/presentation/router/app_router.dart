import 'package:deskify/features/presentation/subpages/subpages.dart';
import 'package:flutter/material.dart';

/// This class provides the routing of the subpages for the application.
///
/// The actual pages, which can be clicked in the BottomNavigationBar, are
/// defined in the [App] class.
class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home/standing_analytics':
        return MaterialPageRoute(builder: (_) => const AnalyticsPage());
      case '/home/sitting_analytics':
        return MaterialPageRoute(builder: (_) => const AnalyticsPage());
      case '/home/add_preset':
        return MaterialPageRoute(builder: (_) => const PresetPage());
      case '/home/edit_preset':
        return MaterialPageRoute(builder: (_) => const PresetPage());
      case '/home/move_desk':
        return MaterialPageRoute(builder: (_) => const MoveDeskPage());
      case '/add_desk/add_preset':
        return MaterialPageRoute(builder: (_) => const PresetPage());
      case '/add_desk/edit_preset':
        return MaterialPageRoute(builder: (_) => const PresetPage());
      default:
        return null;
    }
  }
}
