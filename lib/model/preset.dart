import 'package:deskify/model/desk.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Preset {
  String id = const Uuid().v4();
  String? title;
  double? targetHeight;
  Icon? icon;

  Preset({
    this.title = "Preset 1",
    this.targetHeight = Desk.minimumHeight,
    this.icon = const Icon(Icons.abc),
  });
}
