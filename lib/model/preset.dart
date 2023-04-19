import 'package:deskify/model/desk.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Preset {
  final String id = const Uuid().v4();
  String title;
  double targetHeight;
  Icon icon;

  Preset({
    required this.title,
    this.targetHeight = Desk.minimumHeight,
    this.icon = const Icon(Icons.input),
  });
}
