import 'package:deskify/model/preset.dart';
import 'package:uuid/uuid.dart';

class Desk {
  final String id = const Uuid().v4();
  String? name;
  double? height;
  List<Preset>? presets;

  static const double minimumHeight = 72.0;
  static const double maximumHeight = 119.0;
  static const double standingBreakpointHeight = 90.0;

  Desk({
    this.name = 'Deskified Desk',
    this.height = minimumHeight,
    this.presets = const [],
  });

  static double getInboundHeight(double height) {
    if (height < minimumHeight) {
      return minimumHeight;
    }
    if (height > maximumHeight) {
      return maximumHeight;
    }
    return height;
  }
}
