import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PresetWidgetPage extends StatefulWidget {
  final Preset preset;

  const PresetWidgetPage({
    required this.preset,
    super.key,
  });

  @override
  State<PresetWidgetPage> createState() => _PresetWidgetPageState();
}

class _PresetWidgetPageState extends State<PresetWidgetPage> {
  late DeskProvider deskProvider;
  late Desk currentDesk;
  late Preset providerPreset;

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    currentDesk = deskProvider.currentDesk;
    providerPreset = deskProvider.getPreset(currentDesk.id, widget.preset.id);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text(providerPreset.title)),
          Center(
              child: Text("Target-Height: ${providerPreset.targetHeight} cm")),
          _buildDeskAnimation(),
          _buildSliderWidget(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: providerPreset.targetHeight,
      ),
    );
  }

  Widget _buildSliderWidget() {
    return Expanded(
      child: AdjustHeightSlider(
        width: 150.0,
        displayedHeight: providerPreset.targetHeight,
        onChanged: (double value) => deskProvider.setPresetTargetHeight(
          currentDesk.id,
          providerPreset.id,
          value,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
      ),
      child: const Text("Save"),
    );
  }
}
