import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_text_field_with_desk_animation_and_adjust_height_slider.dart';
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
  // late Preset widget.preset;
  late TextEditingController presetTitleController =
      TextEditingController(text: widget.preset.title);
  late TextEditingController presetHeightController =
      TextEditingController(text: widget.preset.targetHeight.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    // widget.preset =
    //     deskProvider.getPreset(deskProvider.currentDesk!.id!, widget.preset.id);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPageHeading(),
          _buildHeightConfiguration(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildPageHeading() {
    void openDialog() => showDialog(
          context: context,
          builder: (_) => SingleValueAlertDialog(
            title: 'Enter new title',
            controller: presetTitleController,
            onSave: () => deskProvider.updatePresetTitle(
                deskProvider.currentDesk!,
                widget.preset,
                presetTitleController.text),
            onCancel: () => presetTitleController.text = widget.preset.title,
          ),
        );

    return Heading(
      title: widget.preset.title,
      nextToHeadingWidgets: [
        const SizedBox(width: 10.0),
        IconButton(
            onPressed: openDialog,
            icon: const Icon(Icons.edit),
            splashRadius: 20.0),
      ],
      onTapped: openDialog,
    );
  }

  Widget _buildHeightConfiguration() {
    return Expanded(
      child: NumericTextFieldWithDeskAnimationAndAdjustHeightSlider(
        deskHeight: double.parse(presetHeightController.text),
        heightTextFieldController: presetHeightController,
        titleOfTextField: 'Target Height',
        onHeightChanged: (double value) =>
            presetHeightController.text = value.toString(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        savePreset();
        Utils.showSnackbar(
          context,
          "The preset '${presetTitleController.text}' was saved.",
        );

        widget.onAboutToPop();
        Navigator.of(context).pop();
      },
      child: const Text('Save'),
    );
  }

  void savePreset() {
    deskProvider.updatePresetTitle(
        deskProvider.currentDesk!, widget.preset, presetTitleController.text);

    deskProvider.updatePresetTargetHeight(
      deskProvider.currentDesk!,
      widget.preset,
      double.parse(presetHeightController.text),
    );
  }
}
