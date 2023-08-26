import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import 'preset.dart';

/// A Desk is a connected height adjustable desk.
class Desk extends Equatable {
  // sad: have to be dynamic, so that I can set the id of the firebase document as an id
  Id id;
  final String name;
  final double height;
  final List<Preset> presets;

  Desk({
    this.id = '-1',
    required this.name,
    required this.height,
    required this.presets,
  });

  @override
  List<Object?> get props => [id, name, height, presets];
}
