import 'package:deskify/model/desk.dart';
import 'package:deskify/utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AdjustHeightSlider extends StatefulWidget {
  final double displayedHeight;
  final void Function(double) onChanged;
  final void Function(double) onChangeEnd;

  const AdjustHeightSlider({
    required this.displayedHeight,
    required this.onChanged,
    required this.onChangeEnd,
    super.key,
  });

  @override
  State<AdjustHeightSlider> createState() => _AdjustHeightSliderState();
}

class _AdjustHeightSliderState extends State<AdjustHeightSlider> {
  @override
  Widget build(BuildContext context) {
    return SfSlider.vertical(
        value: widget.displayedHeight,
        onChanged: (value) => widget.onChanged(value),
        onChangeEnd: (value) => widget.onChangeEnd(value),
        min: Desk.minimumHeight,
        max: Desk.maximumHeight,
        interval: 10,
        showLabels: true,
        showTicks: true,
        enableTooltip: true,
        tooltipTextFormatterCallback: (actualValue, formattedText) =>
            '${Utils.roundDouble(actualValue, 1)} cm',
        labelFormatterCallback: (actualValue, formattedText) =>
            '${Utils.roundDouble(actualValue, 1)} cm');
  }
}
