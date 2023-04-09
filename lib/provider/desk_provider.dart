import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/utils.dart';
import 'package:flutter/material.dart';

class DeskProvider with ChangeNotifier {
  final _desk = Desk(
    name: "Deskified Desk 1",
    height: 72.0,
    presets: [
      Preset(
        title: "Preset1",
        targetHeight: 80.0,
        icon: const Icon(Icons.input),
      ),
      Preset(
        title: "Preset2",
        targetHeight: 90.0,
        icon: const Icon(Icons.input),
      ),
      Preset(
        title: "Preset3",
        targetHeight: 100.0,
        icon: const Icon(Icons.input),
      ),
      Preset(
        title: "Preset3",
        targetHeight: 100.0,
        icon: const Icon(Icons.input),
      ),
    ],
  );

  Desk get desk => _desk;
  double get height => _desk.height!;
  String get name => _desk.name!;
  List<Preset> get presets => _desk.presets!;

  set desk(Desk value) {
    _desk.height = Utils.roundDouble(value.height!, 1);
    _desk.name = value.name;
    notifyListeners();
  }

  set height(double value) {
    _desk.height = Utils.roundDouble(value, 1);
    notifyListeners();
  }

  set name(String value) {
    _desk.name = value;
    notifyListeners();
  }
}
