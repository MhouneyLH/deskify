import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../model/desk.dart';
import '../model/preset.dart';
import '../utils.dart';

// makes the desks (and so presets, etc.) available for the app
// = connection between the app and the database
class DeskProvider with ChangeNotifier {
  List<Desk> _desks = [];
  int _currentlySelectedIndex = 0;

  DeskProvider() {
    _subscribeToDesks();
  }

  void _subscribeToDesks() => FirebaseFirestore.instance
          .collection(FirebaseApi.deskCollectionName)
          .snapshots()
          .listen(
        (snapshot) async {
          final List<Desk> desks = await FirebaseApi.readDesks();
          setDesks(desks);
        },
      );

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

  /// PRESET ///
  void addPreset(Desk desk, Preset preset) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          desk.presets.add(preset);

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );

  void updatePreset(Desk desk, Preset preset, Preset newPreset) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          final int index = desk.presets.indexWhere(
            (element) => element.id == preset.id,
          );

          desk.presets[index] = newPreset;

          FirebaseApi.updateDesk(desk);
          notifyListeners();
        },
      );
}
