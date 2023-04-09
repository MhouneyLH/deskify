import 'package:deskify/model/desk.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
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
  Widget _buildDeskAnimation() {
    return const Center(
      child: DeskAnimation(
        width: 200,
        height: Desk.minimumHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DeskProvider deskProvider = Provider.of<DeskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("MoveWidgetPage"),
          Text(deskProvider.name),
          Text("Height: ${deskProvider.height} cm"),
          _buildDeskAnimation(),
          const Expanded(child: AdjustHeightSlider()),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
