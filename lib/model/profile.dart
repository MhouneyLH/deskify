import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Target {
  double targetValue;
  double actualValue;

  Target({
    required this.targetValue,
    this.actualValue = 0.0,
  });
}

class Profile {
  final String id = const Uuid().v4();
  String? name;
  String? email;
  String? password;
  Icon image;

  Target? standingTimeTarget;
  Target? sittingTimeTarget;

  Map<int, Target>? standingAnalytic = {
    DateTime.monday: Target(targetValue: 0.0),
    DateTime.tuesday: Target(targetValue: 0.0),
    DateTime.wednesday: Target(targetValue: 0.0),
    DateTime.thursday: Target(targetValue: 0.0),
    DateTime.friday: Target(targetValue: 0.0),
    DateTime.saturday: Target(targetValue: 0.0),
    DateTime.sunday: Target(targetValue: 0.0),
  };
  Map<int, Target>? sittingAnalytic = {
    DateTime.monday: Target(targetValue: 0.0),
    DateTime.tuesday: Target(targetValue: 0.0),
    DateTime.wednesday: Target(targetValue: 0.0),
    DateTime.thursday: Target(targetValue: 0.0),
    DateTime.friday: Target(targetValue: 0.0),
    DateTime.saturday: Target(targetValue: 0.0),
    DateTime.sunday: Target(targetValue: 0.0),
  };

  Profile({
    this.name,
    this.email,
    this.password,
    this.image = const Icon(Icons.person),
    this.standingTimeTarget,
    this.sittingTimeTarget,
    this.standingAnalytic,
    this.sittingAnalytic,
  });
}
