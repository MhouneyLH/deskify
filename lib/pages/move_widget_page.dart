import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveWidgetPage extends StatefulWidget {
  const MoveWidgetPage({
    super.key,
  });

  @override
  State<MoveWidgetPage> createState() => _MoveWidgetPageState();
}

class _MoveWidgetPageState extends State<MoveWidgetPage> {
  @override
  Widget build(BuildContext context) {
    final DeskProvider deskProvider = Provider.of<DeskProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("MoveWidgetPage"),
        Text(deskProvider.name),
        Text("Height: ${deskProvider.height} cm"),
        const AdjustHeightSlider(),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Back"),
        ),
      ],
    );
  }
}
