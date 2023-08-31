import 'package:deskify/core/core.dart';
import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/desk.dart';
import '../../../domain/entities/preset.dart';
import '../../bloc/desk/desk_bloc.dart';
import '../../themes/theme.dart';
import 'preset_card.dart';

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

  @override
  void initState() {
    super.initState();

    newDesk = newDesk.copyWith(
      presets: const <Preset>[
        Preset(
          id: '0',
          name: 'Sitting',
          targetHeight: 0.0,
        ),
        Preset(
          id: '1',
          name: 'Standing',
          targetHeight: 1.0,
        ),
      ],
    );
  }

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
          onEditingComplete: () {
            setState(() {
              newDesk = newDesk.copyWith(name: deskNameController.text);
            });
          },
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        TextField(
          controller: deskHeightController,
          decoration: const InputDecoration(
            labelText: 'Desk Height',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          key: const Key('desk-height-text-field'),
          onEditingComplete: () {
            setState(() {
              newDesk = newDesk.copyWith(
                height: double.parse(deskHeightController.text),
              );
            });
          },
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
        for (final Preset preset in newDesk.presets)
          Column(
            children: [
              PresetCard(
                preset: preset,
                key: Key('preset-card-${preset.name}'),
              ),
              const SizedBox(height: ThemeSettings.smallSpacing),
            ],
          ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        Center(
          child: IconButton(
            icon: const Icon(Icons.add),
            iconSize: 30.0,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              iconColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: ThemeSettings.largeSpacing * 2),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: ElevatedButton(
              key: const Key('add-desk-button'),
              onPressed: () {
                BlocProvider.of<DeskBloc>(context).add(
                  CreatedDesk(desk: newDesk),
                );

                _clearInputs();
              },
              child: Text(
                'Add Desk',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _clearInputs() {
    setState(() {
      newDesk = Desk.empty();

      deskNameController.clear();
      deskHeightController.text = newDesk.height.toStringAsFixed(2);
    });
  }
}
