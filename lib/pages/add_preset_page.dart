import 'package:deskify/model/desk.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPresetPage extends StatefulWidget {
  final void Function() onAboutToPop;

  const AddPresetPage({
    required this.onAboutToPop,
    super.key,
  });

  @override
  State<AddPresetPage> createState() => _AddPresetPageState();
}

class _AddPresetPageState extends State<AddPresetPage> {
  late DeskProvider deskProvider;
  late final TextEditingController presetTitleController =
      TextEditingController();
  late final TextEditingController presetTargetHeightController =
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
          const Heading(title: "Add Preset"),
          TextField(
            controller: presetTitleController,
            decoration: const InputDecoration(labelText: 'Preset Name'),
          ),
          _buildHeightDisplayingInteractiveTextField(
            controller: presetTargetHeightController,
            labelText: "Target Height",
          ),
          const SizedBox(height: 10.0),
          _buildDeskAnimation(),
          _buildSliderWidget(),
          _buildAddButton(),
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
            controller.text = Desk.minimumHeight.toString();
            return;
          }

          final double inboundHeight =
              Desk.getInboundHeight(double.parse(value));
          controller.text = Utils.roundDouble(inboundHeight, 1).toString();
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
        displayedHeight: double.parse(presetTargetHeightController.text),
        onChanged: (double value) => setState(
          () {
            presetTargetHeightController.text =
                Utils.roundDouble(value, 1).toString();
          },
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () {
        addPreset();
        widget.onAboutToPop();
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
      ),
      child: const Text("Save"),
    );
  }

  void addPreset() {
    deskProvider.addPreset(
      deskProvider.currentDesk.id,
      title: presetTitleController.text,
      targetHeight: double.parse(presetTargetHeightController.text),
    );
  }
}
