import 'dart:convert';

import '../../../core/core.dart';
import '../../domain/entities/preset.dart';

/// This class is the data model for the [Preset] entity that is contained in [DeskModel].
///
/// It is used as a data transfer object between the data and domain layer.
class PresetModel extends Preset {
  const PresetModel({
    required super.id,
    required super.name,
    required super.targetHeight,
  });

  /// Creates a [PresetModel] from a [Preset] entity.
  factory PresetModel.fromEntity(Preset preset) {
    return PresetModel(
      id: preset.id,
      name: preset.name,
      targetHeight: preset.targetHeight,
    );
  }

  /// Creates a [Preset] entity from a [PresetModel].
  Preset toEntity() {
    return Preset(
      id: id,
      name: name,
      targetHeight: targetHeight,
    );
  }

  /// Creates a [PresetModel] from a map.
  factory PresetModel.fromMap(Map<String, dynamic> map) {
    return PresetModel(
      id: map['id'] as Id,
      name: map['name'] as String,
      targetHeight: map['targetHeight'] as double,
    );
  }

  /// Creates a map from a [PresetModel].
  ///
  /// This map is used to store the [PresetModel] in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'targetHeight': targetHeight,
    };
  }

  /// Creates a [PresetModel] from a json string.
  factory PresetModel.fromJson(String source) =>
      PresetModel.fromMap(json.decode(source));

  /// Creates a json string from a [PresetModel].
  String toJson(PresetModel model) => json.encode(model.toMap());
}
