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

    // TODO: delete later, when add button is working!
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
        _buildDeskNameTextField(),
        const SizedBox(height: ThemeSettings.smallSpacing),
        _buildDeskHeightTextField(),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDeskConfigurationAnimation(context),
            _buildHeightSlider(),
          ],
        ),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(
          title: 'Presets',
          key: Key('presets-heading'),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getAllConfiguredPresetCards(),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        _buildAddPresetButton(context),
        const SizedBox(height: ThemeSettings.largeSpacing * 2),
        _buildAddDeskButton(context),
      ],
    );
  }

  TextField _buildDeskNameTextField() {
    return TextField(
      controller: deskNameController,
      decoration: const InputDecoration(
        labelText: 'Desk Name',
      ),
      key: const Key('desk-name-text-field'),
      onEditingComplete: () {
        _updateDeskName();
      },
    );
  }

  TextField _buildDeskHeightTextField() {
    return TextField(
      controller: deskHeightController,
      decoration: const InputDecoration(
        labelText: 'Desk Height',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      key: const Key('desk-height-text-field'),
      onEditingComplete: () {
        _updateDeskHeight();
      },
    );
  }

  SizedBox _buildDeskConfigurationAnimation(BuildContext context) {
    return SizedBox(
      height: deskMaximumHeight + DeskAnimation.topOfDeskThickness,
      width: MediaQuery.of(context).size.width * 0.5,
      child: DeskAnimation(
        width: MediaQuery.of(context).size.width * 0.6,
        deskHeight: newDesk.height,
        key: const Key('desk-animation'),
      ),
    );
  }

  HeightSlider _buildHeightSlider() {
    return HeightSlider(
      deskHeight: newDesk.height,
      key: const Key('desk-height-slider'),
      onChanged: (double newHeight) {
        setState(() {
          deskHeightController.text = newHeight.toStringAsFixed(2);
        });
        _updateDeskHeight();
      },
      onChangeEnd: (double newHeight) {
        setState(() {
          deskHeightController.text = newHeight.toStringAsFixed(2);
        });
        _updateDeskHeight();
      },
    );
  }

  Center _buildAddPresetButton(BuildContext context) {
    return Center(
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
    );
  }

  Center _buildAddDeskButton(BuildContext context) {
    return Center(
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
    );
  }

  List<PresetCard> _getAllConfiguredPresetCards() {
    List<PresetCard> presetCards = [];

    for (final Preset preset in newDesk.presets) {
      final PresetCard card = PresetCard(
        preset: preset,
        key: Key('preset-card-${preset.name}'),
      );

      presetCards.add(card);
    }

    return presetCards;
  }

  void _updateDeskName() {
    setState(() {
      newDesk = newDesk.copyWith(name: deskNameController.text);
    });
  }

  void _updateDeskHeight() {
    setState(() {
      newDesk = newDesk.copyWith(
        height: double.parse(deskHeightController.text),
      );
    });
  }

  void _clearInputs() {
    setState(() {
      newDesk = Desk.empty();

      deskNameController.clear();
      deskHeightController.text = newDesk.height.toStringAsFixed(2);
    });
  }
}
