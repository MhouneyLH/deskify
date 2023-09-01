import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// A widget that displays a slider to change the height of the desk.
///
/// The slider is displayed as a [SfSlider] internally.
class HeightSlider extends StatefulWidget {
  final double deskHeight;
  final Function(double) onChanged;
  final Function(double) onChangeEnd;

  const HeightSlider({
    required this.deskHeight,
    required this.onChanged,
    required this.onChangeEnd,
    super.key,
  });

  // when to show a number next to the slider
  static const double _interval = 10.0;

  @override
  State<HeightSlider> createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  @override
  Widget build(BuildContext context) {
    return SfSlider.vertical(
      value: widget.deskHeight,
      onChanged: (value) => widget.onChanged(value),
      onChangeEnd: (value) => widget.onChangeEnd(value),
      min: deskMinimumHeight,
      max: deskMaximumHeight,
      interval: HeightSlider._interval,
      showLabels: true,
      showTicks: true,
      // when dragging the bullet of the slider, a tooltip is shown
      enableTooltip: true,
      tooltipTextFormatterCallback: (actualValue, formattedText) =>
          '$formattedText $deskHeightMetric',
      labelFormatterCallback: (actualValue, formattedText) =>
          '$formattedText $deskHeightMetric',
    );
  }
}
