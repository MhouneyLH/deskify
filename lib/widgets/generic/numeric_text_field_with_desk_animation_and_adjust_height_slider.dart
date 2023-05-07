import 'package:deskify/model/desk.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/numeric_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
        _buildHeightDisplayingInteractiveTextField(
          controller: widget.heightTextFieldController,
          labelText: widget.titleOfTextField,
        ),
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
        final double roundedInboundHeight = Utils.roundDouble(inboundHeight, 1);

        _updateComponents(roundedInboundHeight);
        widget.onHeightChanged(roundedInboundHeight);
      },
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

  void _updateComponents(double value) {
    deskHeight = value;
    widget.heightTextFieldController.text = value.toString();
  }
}
