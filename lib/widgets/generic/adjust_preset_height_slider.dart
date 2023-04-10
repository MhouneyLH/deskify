import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AdjustPresetHeightSlider extends StatefulWidget {
  final String? presetId;

  const AdjustPresetHeightSlider({
    this.presetId,
    super.key,
  });

  @override
  State<AdjustPresetHeightSlider> createState() =>
      _AdjustPresetHeightSliderState();
}

class _AdjustPresetHeightSliderState extends State<AdjustPresetHeightSlider> {
  @override
  Widget build(BuildContext context) {
    final DeskProvider deskProvider = Provider.of<DeskProvider>(context);
    final Preset preset = deskProvider.getPreset(widget.presetId!);

    return SfSlider.vertical(
        value: preset.targetHeight,
        onChanged: (value) => deskProvider.setPresetHeight(preset.id, value),
        min: Desk.minimumHeight,
        max: Desk.maximumHeight,
        interval: 10,
        showLabels: true,
        showTicks: true,
        enableTooltip: true,
        tooltipTextFormatterCallback: (actualValue, formattedText) =>
            "${Utils.roundDouble(actualValue, 1)} cm",
        labelFormatterCallback: (actualValue, formattedText) =>
            "${Utils.roundDouble(actualValue, 1)} cm");
  }
}
