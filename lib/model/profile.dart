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

  Target? standingTarget;
  Target? sittingTarget;

  Profile({
    this.name,
    this.email,
    this.password,
    this.standingTarget,
    this.sittingTarget,
  });
}
