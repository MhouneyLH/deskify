import 'package:deskify/core/core.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/desk.dart';
import '../../themes/theme.dart';

/// A page on which a [Desk] entity can be added.
///
/// You can select a name and height for the desk and add presets to it.
class AddDeskPage extends StatefulWidget {
  const AddDeskPage({super.key});

  @override
  State<AddDeskPage> createState() => _AddDeskPageState();
}

class _AddDeskPageState extends State<AddDeskPage> {
  Desk newDesk = Desk.empty();

  final TextEditingController deskNameController = TextEditingController();
  late final TextEditingController deskHeightController =
      TextEditingController(text: newDesk.height.toStringAsFixed(2));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(
          title: 'General',
          key: Key('general-heading'),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        TextField(
          controller: deskNameController,
          decoration: const InputDecoration(
            labelText: 'Desk Name',
          ),
          key: const Key('desk-name-text-field'),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        TextField(
          controller: deskHeightController,
          decoration: const InputDecoration(
            labelText: 'Desk Height',
          ),
          key: const Key('desk-height-text-field'),
        ),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: deskMaximumHeight + DeskAnimation.topOfDeskThickness,
              width: MediaQuery.of(context).size.width * 0.5,
              child: DeskAnimation(
                width: MediaQuery.of(context).size.width * 0.6,
                deskHeight: newDesk.height,
                key: const Key('desk-animation'),
              ),
            ),
            // const Spacer(),
            HeightSlider(
              deskHeight: newDesk.height,
              key: const Key('desk-height-slider'),
              onChanged: (double newHeight) {
                setState(() {
                  newDesk = newDesk.copyWith(height: newHeight);
                  deskHeightController.text = newDesk.height.toStringAsFixed(2);
                });
              },
              onChangeEnd: (double newHeight) {
                setState(() {
                  newDesk = newDesk.copyWith(height: newHeight);
                  deskHeightController.text = newDesk.height.toStringAsFixed(2);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(
          title: 'Presets',
          key: Key('presets-heading'),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
      ],
    );
  }
}
