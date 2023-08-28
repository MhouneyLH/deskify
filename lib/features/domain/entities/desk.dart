// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import 'preset.dart';

/// A Desk is a connected height adjustable desk.
// ignore: must_be_immutable
class Desk extends Equatable {
  // sad: have to be dynamic, so that I can set the id of the firebase document as an id
  Id id;
  final String name;
  final double height;
  final List<Preset> presets;

  Desk({
    this.id = defaultId,
    required this.name,
    required this.height,
    required this.presets,
  });

  factory Desk.empty() {
    return Desk(
      id: defaultId,
      name: '',
      height: 0.0,
      presets: const [],
    );
  }

  @override
  List<Object?> get props => [id, name, height, presets];

  @override
  bool get stringify => true;
}
