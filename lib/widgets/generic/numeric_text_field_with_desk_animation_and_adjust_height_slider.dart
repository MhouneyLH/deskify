import 'package:flutter/material.dart';

import '../../model/desk.dart';
import '../../utils.dart';
import 'adjust_height_slider.dart';
import 'desk_animation.dart';
import 'numeric_textfield.dart';

// collection of different widgets (text field, slider, animation)
// to adjust the height of the current desk / preset / new desk
// no good practice, because of high coupling: shame on me
// -> need these 3 pieces together everytime for now
// change the height wether by text field or slider and see the result immediately in the animation
class NumericTextFieldWithDeskAnimationAndAdjustHeightSlider
    extends StatefulWidget {
  final double defaultDeskHeight;
  final String titleOfTextField;
  final TextEditingController heightTextFieldController;
  final void Function(double) onHeightChanged;

  const NumericTextFieldWithDeskAnimationAndAdjustHeightSlider({
    required this.defaultDeskHeight,
    required this.titleOfTextField,
    required this.heightTextFieldController,
    required this.onHeightChanged,
    super.key,
  });

  @override
  State<NumericTextFieldWithDeskAnimationAndAdjustHeightSlider> createState() =>
      _NumericTextFieldWithDeskAnimationAndAdjustHeightSliderState();
}

class _NumericTextFieldWithDeskAnimationAndAdjustHeightSliderState
    extends State<NumericTextFieldWithDeskAnimationAndAdjustHeightSlider> {
  late double deskHeight;

  @override
  void initState() {
    super.initState();

    deskHeight = widget.defaultDeskHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeightDisplayingInteractiveTextField(),
        const SizedBox(height: 10.0),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeskAnimation(),
              _buildHeightSlider(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeightDisplayingInteractiveTextField() {
    return NumericTextfield(
      controller: widget.heightTextFieldController,
      title: widget.titleOfTextField,
      onSubmitted: (String value) => _updateHeight(value),
    );
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: deskHeight,
      ),
    );
  }

  Widget _buildHeightSlider() {
    return AdjustHeightSlider(
      displayedHeight: deskHeight,
      onChanged: (double value) => setState(() {
        final double roundedValue = Utils.roundDouble(value, 1);

        _updateComponents(roundedValue);
      }),
      onChangeEnd: (double value) => setState(() {
        final double roundedValue = Utils.roundDouble(value, 1);

        _updateComponents(roundedValue);
        widget.onHeightChanged(roundedValue);
      }),
    );
  }

  void _updateHeight(String value) {
    setState(
      () {
        if (double.tryParse(value) == null) {
          _updateComponents(Desk.minimumHeight);

          return;
        }

        final double inboundHeight = Desk.getInboundHeight(double.parse(value));
        final double roundedInboundHeight = Utils.roundDouble(inboundHeight, 1);

        _updateComponents(roundedInboundHeight);
        widget.onHeightChanged(roundedInboundHeight);
      },
    );
  }

  void _updateComponents(double value) {
    deskHeight = value;
    widget.heightTextFieldController.text = value.toString();
  }
}
