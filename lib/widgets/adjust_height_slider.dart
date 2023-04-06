import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AdjustHeightSlider extends StatefulWidget {
  final void Function(double) onValueChanged;

  const AdjustHeightSlider({super.key, required this.onValueChanged});

  @override
  State<AdjustHeightSlider> createState() => _AdjustHeightSliderState();
}

class _AdjustHeightSliderState extends State<AdjustHeightSlider> {
  final double minimalHeight = 72.0;
  final double maximalHeight = 119.0;

  double _currentSliderValue = 72.0;

  void _updateSliderValue(double value) {
    setState(() {
      _currentSliderValue = double.parse(value.toStringAsFixed(1));
    });
    widget.onValueChanged(double.parse(value.toStringAsFixed(1)));
  }

  @override
  Widget build(BuildContext context) {
    return SfSlider.vertical(
      value: _currentSliderValue,
      onChanged: (value) => _updateSliderValue(value),
      min: minimalHeight,
      max: maximalHeight,
      interval: 10,
      showLabels: true,
      showTicks: true,
      enableTooltip: true,
      tooltipTextFormatterCallback: (actualValue, formattedText) =>
          "$_currentSliderValue cm",
      labelFormatterCallback: (actualValue, formattedText) => "$actualValue cm",
    );
  }
}
