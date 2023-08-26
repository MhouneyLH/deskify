import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/preset.dart';
import '../provider/desk_provider.dart';
import '../utils.dart';
import '../widgets/generic/heading_widget.dart';
import '../widgets/generic/numeric_text_field_with_desk_animation_and_adjust_height_slider.dart';
import '../widgets/generic/single_value_alert_dialog.dart';

// edit an existing preset of a desk
// editable is:
// - title
// - target height
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
  late Preset editablePreset = widget.preset;

  late TextEditingController presetTitleController =
      TextEditingController(text: widget.preset.title);
  late TextEditingController presetHeightController =
      TextEditingController(text: widget.preset.targetHeight.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);

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
            onSave: () => setState(
              () => editablePreset.title = presetTitleController.text,
            ),
            onCancel: () => setState(
              () => presetTitleController.text = editablePreset.title,
            ),
          ),
        );

    return Heading(
      title: editablePreset.title,
      nextToHeadingWidgets: [
        const SizedBox(width: 10.0),
        IconButton(
          onPressed: openDialog,
          icon: const Icon(Icons.edit),
          splashRadius: 20.0,
        ),
      ],
      onTapped: openDialog,
    );
  }

  Widget _buildHeightConfiguration() {
    return Expanded(
      child: NumericTextFieldWithDeskAnimationAndAdjustHeightSlider(
        defaultDeskHeight: double.parse(presetHeightController.text),
        heightTextFieldController: presetHeightController,
        titleOfTextField: 'Target Height',
        onHeightChanged: (double value) => setState(
          () {
            editablePreset.targetHeight = value;
            presetHeightController.text = value.toString();
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
          context,
          "The preset '${editablePreset.title}' was saved.",
        );

        widget.onAboutToPop();
        Navigator.of(context).pop();
      },
      child: const Text('Save'),
    );
  }

  void savePreset() => deskProvider.updatePreset(
      deskProvider.currentDesk!, widget.preset, editablePreset);
}
