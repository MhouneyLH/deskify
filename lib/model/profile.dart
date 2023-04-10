import 'package:uuid/uuid.dart';

class Target {
  double targetValue;
  double actualValue;

  Target({
    required this.targetValue,
    required this.actualValue,
  });
}

class Profile {
  final String id = const Uuid().v4();
  String? name;
  String? email;
  String? password;

  Target? standingTarget;
  Target? sittingTarget;
}
