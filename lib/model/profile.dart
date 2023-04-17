import 'package:deskify/model/target.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Profile {
  final String id = const Uuid().v4();
  String name;
  String email;
  String password;
  Icon image;

  Map<int, Target> standingAnalytic = {
    DateTime.monday: Target(),
    DateTime.tuesday: Target(),
    DateTime.wednesday: Target(),
    DateTime.thursday: Target(),
    DateTime.friday: Target(),
    DateTime.saturday: Target(),
    DateTime.sunday: Target(),
  };

  Map<int, Target> sittingAnalytic = {
    DateTime.monday: Target(),
    DateTime.tuesday: Target(),
    DateTime.wednesday: Target(),
    DateTime.thursday: Target(),
    DateTime.friday: Target(),
    DateTime.saturday: Target(),
    DateTime.sunday: Target(),
  };

  Profile({
    required this.name,
    required this.email,
    required this.password,
    required this.standingAnalytic,
    required this.sittingAnalytic,
    this.image = const Icon(Icons.person),
  });
}
