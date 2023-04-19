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
    return AdjustHeightSlider(
      displayedHeight: double.parse(controller.text),
      onChanged: (double value) => setState(
        () {
          controller.text = Utils.roundDouble(value, 1).toString();
        },
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
        _buildAddPresetButton(
          title: presetTitleController.text,
          targetHeight: double.parse(presetTargetHeightController.text),
        ),
      ],
    );
  }

  Widget _buildCurrentAddedPresets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: presetList
          .map((preset) => Text("${preset.title}: ${preset.targetHeight}"))
          .toList(),
    );
  }

  Widget _buildAddPresetButton(
      {required String title, double targetHeight = Desk.minimumHeight}) {
    return ElevatedButton(
      onPressed: () => setState(
        () {
          presetList.add(
            Preset(title: title, targetHeight: targetHeight),
          );
        },
      ),
      child: const Text("Add Preset"),
    );
  }

  Widget _buildAddDeviceButton() {
    return ElevatedButton(
      onPressed: () {
        deskProvider.addDesk(
          name: deskNameController.text,
          height: double.parse(deskHeightController.text),
          presets: presetList,
        );
      },
      child: const Text("Add Device"),
    );
  }
}
