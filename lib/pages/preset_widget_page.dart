import 'package:deskify/model/preset.dart';
import 'package:flutter/material.dart';

class PresetWidgetPage extends StatefulWidget {
  final Preset? preset;

  const PresetWidgetPage({
    this.preset,
    super.key,
  });

  @override
  State<PresetWidgetPage> createState() => _PresetWidgetPageState();
}

class _PresetWidgetPageState extends State<PresetWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
