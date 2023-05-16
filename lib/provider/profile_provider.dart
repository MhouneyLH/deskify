import 'package:flutter/material.dart';

import '../model/profile.dart';
import '../model/target.dart';
import '../utils.dart';

// makes the profile available for the app
// = connection between the app and the database
class ProfileProvider extends ChangeNotifier {
  // currently only a dummy-profile with random values
  final Profile _profile = Profile(
    name: 'Deskified Test User',
    email: 'lucas.mag.huehner@gmail.com',
    password: '123456',
    standingAnalytic: {
      DateTime.monday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(3.0)),
      DateTime.tuesday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(4.0)),
      DateTime.wednesday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(1.5)),
      DateTime.thursday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(9.0)),
      DateTime.friday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(6.6)),
      DateTime.saturday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(3.7)),
      DateTime.sunday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(4.3)),
    },
    sittingAnalytic: {
      DateTime.monday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(7.0)),
      DateTime.tuesday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(2.0)),
      DateTime.wednesday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(2.5)),
      DateTime.thursday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(2.0)),
      DateTime.friday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(3.0)),
      DateTime.saturday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(1.0)),
      DateTime.sunday:
          TimeTarget(targetValueInSeconds: Utils.minutesToSeconds(6.5)),
    },
  );

  Profile get profile => _profile;
  String get name => _profile.name;
  String get email => _profile.email;
  Icon get image => _profile.image;

  Map<int, TimeTarget> get standingAnalytic => _profile.standingAnalytic;
  Map<int, TimeTarget> get sittingAnalytic => _profile.sittingAnalytic;
  TimeTarget get todaysStandingTarget =>
      _profile.standingAnalytic[Utils.getCurrentWeekdayAsInt()]!;
  TimeTarget get todaysSittingTarget =>
      _profile.sittingAnalytic[Utils.getCurrentWeekdayAsInt()]!;

  void incrementStandingAnalytic(int weekday, int value) {
    _profile.standingAnalytic[weekday]!.actualValueInSeconds += value;
    notifyListeners();
  }

  void incrementSittingAnalytic(int weekday, int value) {
    _profile.sittingAnalytic[weekday]!.actualValueInSeconds += value;
    notifyListeners();
  }

  double getTargetProgressAsPercent(TimeTarget target) {
    return target.actualValueInSeconds / target.targetValueInSeconds;
  }
}
