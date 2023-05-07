import 'package:deskify/model/preset.dart';

class Desk {
  String? id;
  String? name;
  double? height;
  List<Preset> presets;

  static const double minimumHeight = 72.0;
  static const double maximumHeight = 119.0;
  static const double standingBreakpointHeight = 90.0;

  Desk({
    this.id,
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

  static Desk fromJson(Map<String, dynamic> json) => Desk(
        id: json['id'],
        name: json['name'],
        height: json['height'],
        presets: List<Preset>.from(
            json['presets'].map((preset) => Preset.fromJson(preset))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'height': height,
        'presets': presets.map((Preset preset) => preset.toJson()).toList(),
      };
}
