import 'package:deskify/model/desk.dart';
import 'package:deskify/widgets/adjust_height_slider.dart';
import 'package:flutter/material.dart';

class MoveWidgetPage extends StatefulWidget {
  final Desk? desk;
  final void Function(double)? onValueChanged;

  const MoveWidgetPage({
    @required this.desk,
    @required this.onValueChanged,
    super.key,
  });

  @override
  State<MoveWidgetPage> createState() => _MoveWidgetPageState();
}

class _MoveWidgetPageState extends State<MoveWidgetPage> {
  void _updateCurrentDeskHeight(double value) {
    setState(() {
      widget.desk!.height = value;
    });
    widget.onValueChanged!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("MoveWidgetPage"),
        Text("${widget.desk!.name}"),
        Text("Height: ${widget.desk!.height} cm"),
        AdjustHeightSlider(
          onValueChanged: _updateCurrentDeskHeight,
          initialSliderValue: widget.desk!.height,
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Back"),
        ),
      ],
    );
  }
}
