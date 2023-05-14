import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_text_field_with_desk_animation_and_adjust_height_slider.dart';
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
  late final Preset newPreset = Preset(
    title: '',
    targetHeight: deskProvider.currentDesk!.height,
  );

  final TextEditingController presetTitleController = TextEditingController();
  late final TextEditingController presetTargetHeightController =
      TextEditingController(text: newPreset.targetHeight.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Heading(title: 'Add Preset'),
          TextField(
            controller: presetTitleController,
            decoration: const InputDecoration(labelText: 'Preset Name'),
          ),
          _buildHeightConfiguration(),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildHeightConfiguration() {
    return Expanded(
      child: NumericTextFieldWithDeskAnimationAndAdjustHeightSlider(
        defaultDeskHeight: newPreset.targetHeight,
        heightTextFieldController: presetTargetHeightController,
        titleOfTextField: 'Target Height',
        onHeightChanged: (double value) => newPreset.targetHeight = value,
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () {
        if (presetTitleController.text.isEmpty) {
          Utils.showSnackbar(context, 'Enter a preset name.');
          return;
        }

        newPreset.title = presetTitleController.text;
        deskProvider.addPreset(deskProvider.currentDesk!, newPreset);
        Utils.showSnackbar(
            context, "The preset '${newPreset.title}' was added.");

        widget.onAboutToPop();
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
      ),
      child: const Text('Save'),
    );
  }
}
