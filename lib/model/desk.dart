import 'package:deskify/model/preset.dart';

class Desk {
  String? name;
  double? height;
  List<Preset>? presets;

  static const double minimumHeight = 72.0;
  static const double maximumHeight = 119.0;
  static const double standingBreakpointHeight = 90.0;

  Desk({
    this.name = "Deskified Desk",
    this.height = minimumHeight,
    this.presets = const [],
  });
}
