// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

/// A preset is a set of settings for a [Desk].
class Preset extends Equatable {
  final Id id;
  final String name;
  final double targetHeight;

  const Preset({
    required this.id,
    required this.name,
    required this.targetHeight,
  });

  @override
  List<Object?> get props => [id, name, targetHeight];

  @override
  bool get stringify => true;
}
