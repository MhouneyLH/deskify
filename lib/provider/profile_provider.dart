import 'package:deskify/model/profile.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final Profile _profile = Profile(
    name: "Deskified Test User",
    email: "lucas.mag.huehner@gmail.com",
    password: "123456",
    standingTimeTarget: Target(
      targetValue: 30,
    ),
    sittingTimeTarget: Target(
      targetValue: 20,
    ),
  );

  Profile get profile => _profile;
  String get id => _profile.id;
  String? get name => _profile.name;
  String? get email => _profile.email;
  String? get password => _profile.password;
  Icon get image => _profile.image;
  Target? get standingTimeTarget => _profile.standingTimeTarget;
  Target? get sittingTimeTarget => _profile.sittingTimeTarget;
  Map<int, Target>? get standingAnalytic => _profile.standingAnalytic;
  Map<int, Target>? get sittingAnalytic => _profile.sittingAnalytic;

  set profile(Profile value) {
    _profile.name = value.name;
    _profile.email = value.email;
    _profile.password = value.password;
    _profile.standingTimeTarget = value.standingTimeTarget;
    _profile.sittingTimeTarget = value.sittingTimeTarget;
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

  set standingTimeTarget(Target? value) {
    _profile.standingTimeTarget = value;
    notifyListeners();
  }

  set sittingTimeTarget(Target? value) {
    _profile.sittingTimeTarget = value;
    notifyListeners();
  }

  void updateStandingTimeActual(double value) {
    _profile.standingTimeTarget!.actualValue = value;
    notifyListeners();
  }

  void updateSittingTimeActual(double value) {
    _profile.sittingTimeTarget!.actualValue = value;
    notifyListeners();
  }

  void addStandingTimeActual(double value) {
    _profile.standingTimeTarget!.actualValue += value;
    notifyListeners();
  }

  void addSittingTimeActual(double value) {
    _profile.sittingTimeTarget!.actualValue += value;
    notifyListeners();
  }

  // TODO: darüber nachdenken, dass ich einfach nur den Ansatz mit dem derzeitigen Tag nehme
  // könnte immer DateTime.now() verwenden, um darauf zu mappen
  // Bei Target-Values einfach immer das aktuellste mitspeichern
  // nach jeder Woche clearen (Die Woche ist dann für mich einfach immer am Montag einer jeden neuen Woche vorbei)

  void updateStandingAnalytic(int weekday, int value) {
    _profile.standingAnalytic![weekday]!.actualValue = value.toDouble();
    notifyListeners();
  }

  void updateSittistandingngAnalytic(int weekday, int value) {
    _profile.sittingAnalytic![weekday]!.actualValue = value.toDouble();
    notifyListeners();
  }
}
