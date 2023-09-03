import 'package:flutter/material.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({super.key});

  @override
  State<PresetPage> createState() => _PresetPageState();
}

class _PresetPageState extends State<PresetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preset Page'),
      ),
      body: const Placeholder(),
    );
  }
}
