import 'package:deskify/model/desk.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveWidgetPage extends StatefulWidget {
  const MoveWidgetPage({super.key});

  @override
  State<MoveWidgetPage> createState() => _MoveWidgetPageState();
}

class _MoveWidgetPageState extends State<MoveWidgetPage> {
  late DeskProvider deskProvider;
  late Desk currentDesk;

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    currentDesk = deskProvider.currentDesk;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(currentDesk.name!),
          Text("Height: ${currentDesk.height} cm"),
          _buildDeskAnimation(),
          _buildSliderWidget(),
        ],
      ),
    );
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: currentDesk.height!,
      ),
    );
  }

  Widget _buildSliderWidget() {
    return Expanded(
      child: AdjustHeightSlider(
        width: 150.0,
        displayedHeight: currentDesk.height!,
        onChanged: (double value) =>
            deskProvider.setHeight(currentDesk.id, value),
      ),
    );
  }
}
