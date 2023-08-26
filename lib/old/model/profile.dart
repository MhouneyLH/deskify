import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'target.dart';

// currently just used as placeholder for the analytical information
// (standing and sitting time)
// TODO: in future = contains desks + google-auth
class Profile {
  final String id = const Uuid().v4();
  String name;
  String email;
  String password;
  Icon image;

  Map<int, TimeTarget> standingAnalytic = {
    DateTime.monday: TimeTarget(),
    DateTime.tuesday: TimeTarget(),
    DateTime.wednesday: TimeTarget(),
    DateTime.thursday: TimeTarget(),
    DateTime.friday: TimeTarget(),
    DateTime.saturday: TimeTarget(),
    DateTime.sunday: TimeTarget(),
  };

  Map<int, TimeTarget> sittingAnalytic = {
    DateTime.monday: TimeTarget(),
    DateTime.tuesday: TimeTarget(),
    DateTime.wednesday: TimeTarget(),
    DateTime.thursday: TimeTarget(),
    DateTime.friday: TimeTarget(),
    DateTime.saturday: TimeTarget(),
    DateTime.sunday: TimeTarget(),
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
