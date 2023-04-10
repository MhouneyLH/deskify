import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/adjust_preset_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget _buildDeskAnimation() {
    return const Center(
      child: DeskAnimation(
        width: 200,
        height: Desk.minimumHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DeskProvider deskProvider = Provider.of<DeskProvider>(context);
    final Preset providerPreset = deskProvider.getPreset(widget.preset!.id);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(providerPreset.id),
          Text(providerPreset.title!),
          Text("Target-Height: ${providerPreset.targetHeight} cm"),
          _buildDeskAnimation(),
          Expanded(
            child: AdjustPresetHeightSlider(
              presetId: providerPreset.id,
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
