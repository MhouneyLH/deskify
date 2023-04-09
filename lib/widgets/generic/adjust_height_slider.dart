import 'package:deskify/provider/desk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AdjustHeightSlider extends StatefulWidget {
  const AdjustHeightSlider({super.key});

  @override
  State<AdjustHeightSlider> createState() => _AdjustHeightSliderState();
}

class _AdjustHeightSliderState extends State<AdjustHeightSlider> {
  final double minimalHeight = 72.0;
  final double maximalHeight = 119.0;

  @override
  Widget build(BuildContext context) {
    final DeskProvider deskProvider = Provider.of<DeskProvider>(context);

    return SfSlider.vertical(
        value: deskProvider.height,
        onChanged: (value) => deskProvider.height = value,
        min: minimalHeight,
        max: maximalHeight,
        interval: 10,
        showLabels: true,
        showTicks: true,
        enableTooltip: true,
        tooltipTextFormatterCallback: (actualValue, formattedText) =>
            "${deskProvider.height} cm",
        labelFormatterCallback: (actualValue, formattedText) =>
            "${deskProvider.height} cm");
  }
}
