import 'package:deskify/model/desk.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/numeric_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NumericTextFieldWithDeskAnimationAndAdjustHeightSlider
    extends StatefulWidget {
  double deskHeight;
  final String titleOfTextField;
  final TextEditingController heightTextFieldController;
  final void Function(double) onHeightChanged;

  NumericTextFieldWithDeskAnimationAndAdjustHeightSlider({
    required this.deskHeight,
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeightDisplayingInteractiveTextField(
          controller: widget.heightTextFieldController,
          labelText: widget.titleOfTextField,
        ),
        const SizedBox(height: 10.0),
        _buildDeskAnimation(),
        _buildHeightSlider(),
      ],
    );
  }

  Widget _buildHeightDisplayingInteractiveTextField(
      {required TextEditingController controller, required String labelText}) {
    return NumericTextfield(
      controller: controller,
      title: labelText,
      onSubmitted: (String value) => _updateHeight(value),
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
        _updateComponents(inboundHeight);
      },
    );
  }

  void _updateComponents(double value) {
    final double roundedValue = Utils.roundDouble(value, 1);

    widget.deskHeight = roundedValue;
    widget.heightTextFieldController.text = roundedValue.toString();
    widget.onHeightChanged(roundedValue);
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: widget.deskHeight,
      ),
    );
  }

  Widget _buildHeightSlider() {
    return Expanded(
      child: AdjustHeightSlider(
        width: 150.0,
        displayedHeight: widget.deskHeight,
        onChanged: (double value) => setState(() => _updateComponents(value)),
      ),
    );
  }
}
