import 'package:deskify/model/desk.dart';
import 'package:flutter/material.dart';

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
        // icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'targetHeight': targetHeight,
        // 'icon': icon,
      };
}
