import 'package:flutter/material.dart';

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
    return RotatedBox(
      quarterTurns: 3,
      child: Slider(
        value: _currentSliderValue,
        min: minimalHeight,
        max: maximalHeight,
        label: _currentSliderValue.toString(),
        divisions: 10 * (maximalHeight - minimalHeight).toInt(),
        onChanged: _updateSliderValue,
      ),
    );
  }
}
