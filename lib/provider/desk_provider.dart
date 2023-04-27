import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/utils.dart';
import 'package:flutter/material.dart';

class DeskProvider with ChangeNotifier {
  final List<Desk> _deskList = [
    Desk(
      name: 'Deskified Desk 1',
      height: 72.0,
      presets: [
        Preset(
          title: 'Preset1',
          targetHeight: 80.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset2',
          targetHeight: 90.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset3',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
      ],
    ),
    Desk(
      name: 'Deskified Desk 2',
      height: 119.0,
      presets: [
        Preset(
          title: 'Preset122',
          targetHeight: 80.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset222',
          targetHeight: 90.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset322',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
        Preset(
          title: 'Preset322',
          targetHeight: 100.0,
          icon: const Icon(Icons.input),
        ),
      ],
    ),
  ];
  int _currentlySelectedIndex = 1;

  List<Desk> get deskList => _deskList;
  Desk get currentDesk => _deskList[_currentlySelectedIndex];
  int get currentlySelectedIndex => _currentlySelectedIndex;
  Desk getDesk(String id) => _deskList.firstWhere((desk) => desk.id == id);
  double getHeight(String id) => getDesk(id).height!;
  String getName(String id) => getDesk(id).name!;
  List<Preset> getPresets(String id) => getDesk(id).presets!;
  Preset getPreset(String deskId, String presetId) =>
      getPresets(deskId).firstWhere((preset) => preset.id == presetId);

  set currentlySelectedIndex(int value) {
    _currentlySelectedIndex = value;
    notifyListeners();
  }

  void setHeight(String id, double value) {
    Desk desk = getDesk(id);

    double inboundHeight = Desk.getInboundHeight(value);
    desk.height = Utils.roundDouble(inboundHeight, 1);

    notifyListeners();
  }

  void setName(String id, String value) {
    Desk desk = getDesk(id);
    desk.name = value;
    notifyListeners();
  }

  void setPresets(String id, List<Preset> value) {
    Desk desk = getDesk(id);
    desk.presets = value;
    notifyListeners();
  }

  void setPresetTitle(String deskId, String presetId, String value) {
    Preset preset = getPreset(deskId, presetId);
    preset.title = value;
    notifyListeners();
  }

  void setPresetTargetHeight(String deskId, String presetId, double value) {
    Preset preset = getPreset(deskId, presetId);
    preset.targetHeight = Utils.roundDouble(value, 1);
    notifyListeners();
  }

  void addDesk(Desk desk) {
    _deskList.add(desk);
    notifyListeners();
  }

  void addPreset(String deskId, Preset preset) {
    Desk desk = getDesk(deskId);
    desk.presets!.add(preset);

    notifyListeners();
  }
}
