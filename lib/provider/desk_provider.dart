import 'package:deskify/api/firebase_api.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/utils.dart';
import 'package:flutter/material.dart';

class DeskProvider with ChangeNotifier {
  List<Desk> _desks = [];
  int _currentlySelectedIndex = 0;

  /// DESK ///
  List<Desk> get desks => _desks;
  Desk? get currentDesk =>
      _desks.isNotEmpty ? _desks[_currentlySelectedIndex] : Desk();

  int get currentlySelectedIndex => _currentlySelectedIndex;

  set currentlySelectedIndex(int value) {
    _currentlySelectedIndex = value;
    notifyListeners();
  }

  void setDesks(List<Desk> desks) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _desks = desks;
          notifyListeners();
        },
      );

  void addDesk(Desk desk) => FirebaseApi.createDesk(desk);

  void udpateDeskName(Desk desk, String name) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          desk.name = name;
          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );

  void udpateDeskHeight(Desk desk, double height) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          final double inboundHeight = Desk.getInboundHeight(height);
          desk.height = Utils.roundDouble(inboundHeight, 1);

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );

  void udpateDeskPresets(Desk desk, List<Preset> presets) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          desk.presets = presets;

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );

  /// PRESET ///
  void addPreset(Desk desk, Preset preset) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          desk.presets.add(preset);

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );

  void updatePresetTitle(Desk desk, Preset preset, String title) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          final int index = desk.presets.indexWhere(
            (element) => element.id == preset.id,
          );

          preset.title = title;
          desk.presets[index] = preset;

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );

  void updatePresetTargetHeight(
          Desk desk, Preset preset, double targetHeight) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          preset.targetHeight = Utils.roundDouble(targetHeight, 1);

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );
}
