import 'package:deskify/model/profile.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final Profile _profile = Profile(
    name: "Deskified Test User",
    email: "lucas.mag.huehner@gmail.com",
    password: "123456",
    standingTarget: Target(
      targetValue: 4.0,
    ),
    sittingTarget: Target(
      targetValue: 2.0,
    ),
  );

  Profile get profile => _profile;
  String get id => _profile.id;
  String? get name => _profile.name;
  String? get email => _profile.email;
  String? get password => _profile.password;
  Icon get image => _profile.image;
  Target? get standingTarget => _profile.standingTarget;
  Target? get sittingTarget => _profile.sittingTarget;

  set profile(Profile value) {
    _profile.name = value.name;
    _profile.email = value.email;
    _profile.password = value.password;
    _profile.standingTarget = value.standingTarget;
    _profile.sittingTarget = value.sittingTarget;
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

  set standingTarget(Target? value) {
    _profile.standingTarget = value;
    notifyListeners();
  }

  set sittingTarget(Target? value) {
    _profile.sittingTarget = value;
    notifyListeners();
  }

  void updateStandingTarget(double value) {
    _profile.standingTarget!.targetValue = value;
    notifyListeners();
  }

  void updateSittingTarget(double value) {
    _profile.sittingTarget!.targetValue = value;
    notifyListeners();
  }
}
