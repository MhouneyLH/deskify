import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/desk_provider.dart';
import '../widgets/generic/heading_widget.dart';
import '../widgets/generic/numeric_text_field_with_desk_animation_and_adjust_height_slider.dart';

// change the height of the current desk
class MoveWidgetPage extends StatefulWidget {
  const MoveWidgetPage({super.key});

  @override
  State<MoveWidgetPage> createState() => _MoveWidgetPageState();
}

class _MoveWidgetPageState extends State<MoveWidgetPage> {
  late DeskProvider deskProvider;
  late TextEditingController heightController =
      TextEditingController(text: deskProvider.currentDesk!.height.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Heading(title: deskProvider.currentDesk!.name),
          _buildHeightConfiguration(),
        ],
      ),
    );
  }

  Widget _buildHeightConfiguration() {
    return Expanded(
      child: NumericTextFieldWithDeskAnimationAndAdjustHeightSlider(
        defaultDeskHeight: deskProvider.currentDesk!.height,
        heightTextFieldController: heightController,
        titleOfTextField: 'Current height',
        onHeightChanged: (double value) =>
            deskProvider.udpateDeskHeight(deskProvider.currentDesk!, value),
      ),
    );
  }
}
