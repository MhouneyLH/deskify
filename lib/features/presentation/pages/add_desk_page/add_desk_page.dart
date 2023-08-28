import 'package:flutter/widgets.dart';

/// A page on which a [Desk] entity can be added.
///
/// You can select a name and height for the desk and add presets to it.
class AddDeskPage extends StatefulWidget {
  const AddDeskPage({super.key});

  @override
  State<AddDeskPage> createState() => _AddDeskPageState();
}

class _AddDeskPageState extends State<AddDeskPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('Add Desk Page');
  }
}
