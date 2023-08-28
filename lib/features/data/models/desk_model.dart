import 'dart:convert';

import '../../../core/core.dart';
import '../../domain/entities/desk.dart';
import '../../domain/entities/preset.dart';
import 'preset_model.dart';

/// This class is the data model for the [Desk] entity.
/// 
/// It is used as a data transfer object between the data and domain layer.
// ignore: must_be_immutable
class DeskModel extends Desk {
  DeskModel({
    required super.id,
    required super.name,
    required super.height,
    required super.presets,
  });

  /// Creates a [DeskModel] from a [Desk] entity. 
  factory DeskModel.fromEntity(Desk desk) {
    return DeskModel(
      id: desk.id,
      name: desk.name,
      height: desk.height,
      presets: desk.presets,
    );
  }

  /// Creates a [Desk] entity from a [DeskModel].
  Desk toEntity() {
    return Desk(
      id: id,
      name: name,
      height: height,
      presets: presets,
    );
  }

  /// Creates a [DeskModel] from a map.
  factory DeskModel.fromMap(Map<String, dynamic> map) {
    return DeskModel(
      id: map['id'] as Id,
      name: map['name'] as String,
      height: map['height'] as double,
      presets: List<Preset>.from(
          map['presets'].map((preset) => PresetModel.fromMap(preset))),
    );
  }

  /// Creates a map from a [DeskModel].
  /// 
  /// This map is used to store the [DeskModel] in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'presets': presets
          .map((Preset preset) => PresetModel.fromEntity(preset).toMap())
          .toList(),
    };
  }

  /// Creates a [DeskModel] from a json string.
  factory DeskModel.fromJson(String source) =>
      DeskModel.fromMap(json.decode(source));

  /// Creates a json string from a [DeskModel].
  String toJson(DeskModel model) => json.encode(model.toMap());
}
