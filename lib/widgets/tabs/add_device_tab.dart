import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_text_field_with_desk_animation_and_adjust_height_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDeviceTab extends StatefulWidget {
  const AddDeviceTab({super.key});

  @override
  State<AddDeviceTab> createState() => _AddDeviceTabState();
}

class _AddDeviceTabState extends State<AddDeviceTab> {
  late DeskProvider deskProvider;
  Desk newDesk = Desk(
    name: '',
    height: Desk.minimumHeight,
    presets: [],
  );

  final TextEditingController deskNameController = TextEditingController();
  final TextEditingController deskHeightController =
      TextEditingController(text: Desk.minimumHeight.toString());
  final TextEditingController presetTitleController = TextEditingController();
  final TextEditingController presetTargetHeightController =
      TextEditingController(text: Desk.minimumHeight.toString());

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Heading(title: "General"),
          _buildGeneralInput(),
          const SizedBox(height: 10.0),
          const Heading(title: "Presets"),
          _buildPresetInput(),
          const SizedBox(height: 10.0),
          _buildAddDeviceButton(),
        ],
      ),
    );
  }

  Widget _buildGeneralInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
            controller: deskNameController,
            decoration: const InputDecoration(labelText: 'Device Name')),
        const SizedBox(height: 10.0),
        _buildDeskHeightConfiguration(),
      ],
    );
  }

  Widget _buildDeskHeightConfiguration() {
    return SizedBox(
      height: 400.0,
      child: Expanded(
        child: NumericTextFieldWithDeskAnimationAndAdjustHeightSlider(
          deskHeight: double.parse(deskHeightController.text),
          titleOfTextField: 'Default Height',
          heightTextFieldController: deskHeightController,
          onHeightChanged: (double value) =>
              deskHeightController.text = value.toString(),
        ),
      ),
    );
  }

  Widget _buildPresetHeightConfiguration() {
    return SizedBox(
      height: 400.0,
      child: Expanded(
        child: NumericTextFieldWithDeskAnimationAndAdjustHeightSlider(
          deskHeight: double.parse(presetTargetHeightController.text),
          titleOfTextField: 'Target Height',
          heightTextFieldController: presetTargetHeightController,
          onHeightChanged: (double value) =>
              presetTargetHeightController.text = value.toString(),
        ),
      ),
    );
  }

  Widget _buildPresetInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCurrentAddedPresets(),
        TextField(
          controller: presetTitleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        _buildPresetHeightConfiguration(),
        _buildAddPresetButton(),
      ],
    );
  }

  Widget _buildCurrentAddedPresets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: newDesk.presets!
          .map(
            (Preset preset) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10.0),
                _buildAddedPresetDelegate(preset),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildAddedPresetDelegate(Preset preset) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(preset.title),
            Text("Target height: ${preset.targetHeight} cm"),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPresetButton() {
    return ElevatedButton(
      onPressed: () => setState(
        () {
          if (presetTitleController.text.isEmpty) {
            Utils.showSnackbar(context, "Enter a title for the preset.");
            return;
          }

          newDesk.presets!.add(Preset(
            title: presetTitleController.text,
            targetHeight: double.parse(presetTargetHeightController.text),
          ));
          Utils.showSnackbar(
              context, "The preset '${presetTitleController.text}' added.");

          resetPresetInput();
        },
      ),
      child: const Text("Add Preset"),
    );
  }

  Widget _buildAddDeviceButton() {
    return ElevatedButton(
      onPressed: () {
        if (deskNameController.text.isEmpty) {
          Utils.showSnackbar(context, "Enter a name for the device.");
          return;
        }

        newDesk.name = deskNameController.text;
        newDesk.height = double.parse(deskHeightController.text);

        deskProvider.addDesk(newDesk);
        Utils.showSnackbar(
            context, "The device '${deskNameController.text}' was added.");

        resetTab();
      },
      child: const Text("Add Device"),
    );
  }

  void resetGeneralInput() {
    deskNameController.clear();
    deskHeightController.text = Desk.minimumHeight.toString();
  }

  void resetPresetInput() {
    presetTitleController.clear();
    presetTargetHeightController.text = Desk.minimumHeight.toString();
  }

  void resetTab() {
    resetGeneralInput();
    resetPresetInput();
    newDesk = Desk(
      name: "",
      height: Desk.minimumHeight,
      presets: List<Preset>.empty(growable: true),
    );
  }
}
