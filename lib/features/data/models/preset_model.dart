import 'dart:convert';

import '../../../core/core.dart';
import '../../domain/entities/preset.dart';

class PresetModel extends Preset {
  const PresetModel({
    required super.id,
    required super.name,
    required super.targetHeight,
  });

  factory PresetModel.fromEntity(Preset preset) {
    return PresetModel(
      id: preset.id,
      name: preset.name,
      targetHeight: preset.targetHeight,
    );
  }

  Preset toEntity() {
    return Preset(
      id: id,
      name: name,
      targetHeight: targetHeight,
    );
  }

  factory PresetModel.fromMap(Map<String, dynamic> map) {
    return PresetModel(
      id: map['id'] as Id,
      name: map['name'] as String,
      targetHeight: map['targetHeight'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'targetHeight': targetHeight,
    };
  }

  factory PresetModel.fromJson(String source) =>
      PresetModel.fromMap(json.decode(source));

  String toJson(PresetModel model) => json.encode(model.toMap());
}
