import 'package:deskify/model/desk.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveWidgetPage extends StatefulWidget {
  const MoveWidgetPage({super.key});

  @override
  State<MoveWidgetPage> createState() => _MoveWidgetPageState();
}

class _MoveWidgetPageState extends State<MoveWidgetPage> {
  late DeskProvider deskProvider;
  late TextEditingController heightController =
      TextEditingController(text: deskProvider.currentDesk.height.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Heading(title: deskProvider.currentDesk.name!),
          _buildHeightDisplayingInteractiveTextField(
            controller: heightController,
            labelText: "Target Height",
          ),
          const SizedBox(height: 10.0),
          _buildDeskAnimation(),
          _buildSliderWidget(),
        ],
      ),
    );
  }

  Widget _buildHeightDisplayingInteractiveTextField(
      {required TextEditingController controller, required String labelText}) {
    return NumericTextfield(
      controller: controller,
      title: labelText,
      onSubmitted: (String value) => setState(
        () {
          if (double.tryParse(value) == null) {
            deskProvider.setHeight(
                deskProvider.currentDesk.id, Desk.minimumHeight);
            controller.text = deskProvider.currentDesk.height.toString();

            return;
          }

          final double inboundHeight =
              Desk.getInboundHeight(double.parse(value));
          deskProvider.setHeight(deskProvider.currentDesk.id, inboundHeight);
          controller.text = deskProvider.currentDesk.height.toString();
        },
      ),
    );
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: deskProvider.currentDesk.height!,
      ),
    );
  }

  Widget _buildSliderWidget() {
    return Expanded(
      child: AdjustHeightSlider(
        width: 150.0,
        displayedHeight: deskProvider.currentDesk.height!,
        onChanged: (double value) => setState(
          () {
            deskProvider.setHeight(deskProvider.currentDesk.id, value);
            heightController.text = deskProvider.currentDesk.height.toString();
          },
        ),
      ),
    );
  }
}
