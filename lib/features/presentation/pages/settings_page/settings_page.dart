import 'package:flutter/widgets.dart';

/// A page on which the user can change the app settings. (e. g. change the app theme)
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('Settings Page');
  }
}
