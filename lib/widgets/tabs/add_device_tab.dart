import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/adjust_height_slider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/numeric_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDeviceTab extends StatefulWidget {
  const AddDeviceTab({super.key});

  @override
  State<AddDeviceTab> createState() => _AddDeviceTabState();
}

class _AddDeviceTabState extends State<AddDeviceTab> {
  late DeskProvider deskProvider;
  final TextEditingController deskNameController = TextEditingController();
  final TextEditingController deskHeightController =
      TextEditingController(text: Desk.minimumHeight.toString());
  final TextEditingController presetTitleController = TextEditingController();
  final TextEditingController presetTargetHeightController =
      TextEditingController(text: Desk.minimumHeight.toString());

  List<Preset> presetList = [];

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
        _buildHeightDisplayingInteractiveTextField(
          controller: deskHeightController,
          labelText: 'Default Height',
        ),
        const SizedBox(height: 10.0),
        _buildDeskAnimation(double.parse(deskHeightController.text)),
        const SizedBox(height: 10.0),
        _buildHeightSlider(deskHeightController),
      ],
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

  Widget _buildDeskAnimation(double inputValue) {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: inputValue,
      ),
    );
  }

  Widget _buildHeightSlider(TextEditingController controller) {
    return Align(
      alignment: Alignment.center,
      child: AdjustHeightSlider(
        width: 150.0,
        displayedHeight: double.parse(controller.text),
        onChanged: (double value) => setState(
          () {
            controller.text = Utils.roundDouble(value, 1).toString();
          },
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
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
        ),
        _buildHeightDisplayingInteractiveTextField(
          controller: presetTargetHeightController,
          labelText: 'Target Height',
        ),
        const SizedBox(height: 10.0),
        _buildDeskAnimation(double.parse(presetTargetHeightController.text)),
        _buildHeightSlider(presetTargetHeightController),
        _buildAddPresetButton(),
      ],
    );
  }

  Widget _buildCurrentAddedPresets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: presetList
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
        ));
  }

  Widget _buildAddPresetButton() {
    return ElevatedButton(
      onPressed: () => setState(
        () {
          if (presetTitleController.text.isEmpty) {
            Utils.showSnackbar(context, "Please enter a title for the preset");
            return;
          }

          presetList.add(
            Preset(
              title: presetTitleController.text,
              targetHeight: double.parse(presetTargetHeightController.text),
            ),
          );
          Utils.showSnackbar(
              context, "Preset '${presetTitleController.text}' added");

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
          Utils.showSnackbar(context, "Please enter a name for the device");
          return;
        }

        deskProvider.addDesk(
          name: deskNameController.text,
          height: double.parse(deskHeightController.text),
          presets: presetList,
        );
        Utils.showSnackbar(
            context, "Device '${deskNameController.text}' added");

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
    presetList.clear();
  }
}
