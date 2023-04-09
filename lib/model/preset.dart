import 'package:deskify/model/desk.dart';
import 'package:flutter/material.dart';

class Preset {
  final String? title;
  final double? targetHeight;
  final Icon? icon;

  Preset({
    this.title = "Preset 1",
    this.targetHeight = Desk.minimumHeight,
    this.icon = const Icon(Icons.abc),
  });
}
