import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
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
  final TextEditingController deskDefaultHeightController =
      TextEditingController();
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
          _buildAddButton(),
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
        TextField(
            controller: deskDefaultHeightController,
            decoration: const InputDecoration(labelText: 'Default Heigt')),
      ],
    );
  }

  Widget _buildPresetInput() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController targetHeightController =
        TextEditingController(text: Desk.minimumHeight.toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCurrentAddedPresets(),
        TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            )),
        TextField(
          controller: targetHeightController,
          decoration: const InputDecoration(labelText: 'Target Height'),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            setState(
              () {
                presetList.add(
                  Preset(
                    title: titleController.text,
                    targetHeight:
                        double.tryParse(targetHeightController.text) ??
                            Desk.minimumHeight,
                  ),
                );
              },
            );
          },
          child: const Text("Add Preset"),
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

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () {
        deskProvider.addDesk(
          name: deskNameController.text,
          height: double.tryParse(deskDefaultHeightController.text),
          presets: presetList,
        );
      },
      child: const Text("Add Device"),
    );
  }
}
