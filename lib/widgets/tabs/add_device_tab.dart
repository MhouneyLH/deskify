import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:flutter/material.dart';

class AddDeviceTab extends StatefulWidget {
  const AddDeviceTab({super.key});

  @override
  State<AddDeviceTab> createState() => _AddDeviceTabState();
}

class _AddDeviceTabState extends State<AddDeviceTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Heading(title: "General"),
        _buildGeneralInput(),
        const SizedBox(height: 10.0),
        const Heading(title: "Presets"),
        _buildPresetInput(),
      ],
    );
  }

  Widget _buildGeneralInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TextField(decoration: InputDecoration(labelText: 'Device Name')),
        TextField(decoration: InputDecoration(labelText: 'Default Heigt')),
      ],
    );
  }

  Widget _buildPresetInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TextField(decoration: InputDecoration(labelText: 'Preset Name')),
        TextField(decoration: InputDecoration(labelText: 'Preset Height')),
      ],
    );
  }
}
