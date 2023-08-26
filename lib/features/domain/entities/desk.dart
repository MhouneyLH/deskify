import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import 'preset.dart';

/// A Desk is a connected height adjustable desk.
class Desk extends Equatable {
  final Id id;
  final String name;
  final double height;
  final List<Preset> presets;

  const Desk({
    required this.id,
    required this.name,
    required this.height,
    required this.presets,
  });

  @override
  List<Object?> get props => [id, name, height, presets];
}
