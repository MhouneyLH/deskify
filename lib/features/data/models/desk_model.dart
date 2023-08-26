import 'dart:convert';

import '../../../core/core.dart';
import '../../domain/entities/desk.dart';
import '../../domain/entities/preset.dart';
import 'preset_model.dart';

class DeskModel extends Desk {
  DeskModel({
    required super.id,
    required super.name,
    required super.height,
    required super.presets,
  });

  factory DeskModel.fromEntity(Desk desk) {
    return DeskModel(
      id: desk.id,
      name: desk.name,
      height: desk.height,
      presets: desk.presets,
    );
  }

  Desk toEntity() {
    return Desk(
      id: id,
      name: name,
      height: height,
      presets: presets,
    );
  }

  factory DeskModel.fromMap(Map<String, dynamic> map) {
    return DeskModel(
      id: map['id'] as Id,
      name: map['name'] as String,
      height: map['height'] as double,
      presets: List<Preset>.from(
          map['presets'].map((preset) => PresetModel.fromMap(preset))),
    );
  }

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

  factory DeskModel.fromJson(String source) =>
      DeskModel.fromMap(json.decode(source));

  String toJson(DeskModel model) => json.encode(model.toMap());
}
