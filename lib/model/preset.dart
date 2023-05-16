import 'package:flutter/material.dart';

import 'desk.dart';

// part of the desk
// preset is a height that can be saved and selected
class Preset {
  String? id;
  String title;
  double targetHeight;
  Icon icon;

  Preset({
    this.id,
    required this.title,
    this.targetHeight = Desk.minimumHeight,
    this.icon = const Icon(Icons.input),
  });

  static Preset fromJson(Map<String, dynamic> json) => Preset(
        id: json['id'],
        title: json['title'],
        targetHeight: json['targetHeight'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'targetHeight': targetHeight,
      };
}
