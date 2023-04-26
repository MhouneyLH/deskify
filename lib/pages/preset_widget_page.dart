import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_textfield.dart';
import 'package:deskify/widgets/generic/single_value_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PresetWidgetPage extends StatefulWidget {
  final Preset preset;
  final void Function() onAboutToPop;

  const PresetWidgetPage({
    required this.preset,
    required this.onAboutToPop,
    super.key,
  });

  @override
  State<PresetWidgetPage> createState() => _PresetWidgetPageState();
}

class _PresetWidgetPageState extends State<PresetWidgetPage> {
  late DeskProvider deskProvider;
  late Desk currentDesk;
  late Preset providerPreset;
  late TextEditingController presetTitleController =
      TextEditingController(text: providerPreset.title);
  late TextEditingController presetHeightController =
      TextEditingController(text: providerPreset.targetHeight.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    currentDesk = deskProvider.currentDesk;
    providerPreset = deskProvider.getPreset(currentDesk.id, widget.preset.id);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Heading(
            title: providerPreset.title,
            onTapped: () => showDialog(
              context: context,
              builder: (_) => SingleValueAlertDialog(
                title: "Enter new title",
                controller: presetTitleController,
                onSave: () => deskProvider.setPresetTitle(
                    deskProvider.currentDesk.id,
                    providerPreset.id,
                    presetTitleController.text),
                onCancel: () =>
                    presetTitleController.text = providerPreset.title,
              ),
            ),
          ),
          _buildHeightDisplayingInteractiveTextField(
            controller: presetHeightController,
            labelText: "Target Height",
          ),
          _buildDeskAnimation(),
          _buildSliderWidget(),
          _buildSaveButton(),
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
        deskHeight: providerPreset.targetHeight,
      ),
    );
  }

  Widget _buildSliderWidget() {
    return Expanded(
      child: AdjustHeightSlider(
        width: 150.0,
        displayedHeight: double.parse(presetHeightController.text),
        onChanged: (double value) => setState(
          () {
            presetHeightController.text =
                Utils.roundDouble(value, 1).toString();
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        savePreset();
        Utils.showSnackbar(
            context, "The preset '${presetTitleController.text}' was saved.");
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

  void savePreset() {
    deskProvider.setPresetTargetHeight(
      currentDesk.id,
      providerPreset.id,
      double.parse(presetHeightController.text),
    );
    widget.onAboutToPop();
  }
}
