import 'package:deskify/model/profile.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final Profile _profile = Profile(
    name: "Deskified Test User",
    email: "lucas.mag.huehner@gmail.com",
    password: "123456",
    standingAnalytic: {
      DateTime.monday: Target(targetValue: 3.0),
      DateTime.tuesday: Target(targetValue: 4.0),
      DateTime.wednesday: Target(targetValue: 1.5),
      DateTime.thursday: Target(targetValue: 9.0),
      DateTime.friday: Target(targetValue: 6.6),
      DateTime.saturday: Target(targetValue: 3.7),
      DateTime.sunday: Target(targetValue: 4.3),
    },
    sittingAnalytic: {
      DateTime.monday: Target(targetValue: 7.0),
      DateTime.tuesday: Target(targetValue: 2.0),
      DateTime.wednesday: Target(targetValue: 2.5),
      DateTime.thursday: Target(targetValue: 2.0),
      DateTime.friday: Target(targetValue: 3.0),
      DateTime.saturday: Target(targetValue: 1.0),
      DateTime.sunday: Target(targetValue: 6.5),
    },
  );

  Profile get profile => _profile;
  String get id => _profile.id;
  String? get name => _profile.name;
  String? get email => _profile.email;
  String? get password => _profile.password;
  Icon get image => _profile.image;
  Map<int, Target>? get standingAnalytic => _profile.standingAnalytic;
  Map<int, Target>? get sittingAnalytic => _profile.sittingAnalytic;

  set profile(Profile value) {
    _profile.name = value.name;
    _profile.email = value.email;
    _profile.password = value.password;
    _profile.image = value.image;
    _profile.standingAnalytic = value.standingAnalytic;
    _profile.sittingAnalytic = value.sittingAnalytic;
    notifyListeners();
  }

  set name(String? value) {
    _profile.name = value;
    notifyListeners();
  }

  set email(String? value) {
    _profile.email = value;
    notifyListeners();
  }

  set password(String? value) {
    _profile.password = value;
    notifyListeners();
  }

  set image(Icon value) {
    _profile.image = value;
    notifyListeners();
  }

  void incrementStandingAnalytic(int weekday, int value) {
    _profile.standingAnalytic![weekday]!.actualValue += value;
    notifyListeners();
  }

  void incrementSittingAnalytic(int weekday, int value) {
    _profile.sittingAnalytic![weekday]!.actualValue += value;
    notifyListeners();
  }
}
