import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/desk.dart';
import '../../../domain/entities/preset.dart';
import '../../bloc/desk/desk_bloc.dart';
import '../../themes/theme.dart';
import '../../widgets/widgets.dart';
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

  final TextEditingController deskNameController = TextEditingController();
  late final TextEditingController deskHeightController =
      TextEditingController(text: newDesk.height.toStringAsFixed(2));

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(
          key: Key('general-heading'),
          title: 'General',
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
          key: Key('presets-heading'),
          title: 'Presets',
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
      key: const Key('desk-name-text-field'),
      controller: deskNameController,
      decoration: const InputDecoration(
        labelText: 'Desk Name',
      ),
      onEditingComplete: () {
        _updateDeskName();
      },
    );
  }

  TextField _buildDeskHeightTextField() {
    return TextField(
      key: const Key('desk-height-text-field'),
      controller: deskHeightController,
      decoration: const InputDecoration(
        labelText: 'Desk Height',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (newHeight) {
        double parsedHeight = double.tryParse(newHeight) ?? deskMinimumHeight;

        if (parsedHeight < deskMinimumHeight) {
          parsedHeight = deskMinimumHeight;
        } else if (parsedHeight > deskMaximumHeight) {
          parsedHeight = deskMaximumHeight;
        }

        _updateDeskHeight(parsedHeight);
      },
    );
  }

  SizedBox _buildDeskConfigurationAnimation(BuildContext context) {
    return SizedBox(
      height: deskMaximumHeight + DeskAnimation.topOfDeskThickness,
      width: MediaQuery.of(context).size.width * 0.5,
      child: DeskAnimation(
        key: const Key('desk-animation'),
        width: MediaQuery.of(context).size.width * 0.6,
        deskHeight: newDesk.height,
      ),
    );
  }

  HeightSlider _buildHeightSlider() {
    return HeightSlider(
      key: const Key('desk-height-slider'),
      deskHeight: newDesk.height,
      onChanged: (double newHeight) {
        setState(() {
          deskHeightController.text = newHeight.toStringAsFixed(2);
        });
        _updateDeskHeight(newHeight);
      },
      onChangeEnd: (double newHeight) {
        setState(() {
          deskHeightController.text = newHeight.toStringAsFixed(2);
        });
        _updateDeskHeight(newHeight);
      },
    );
  }

  Center _buildAddPresetButton(BuildContext context) {
    return Center(
      child: IconButton(
        key: const Key('add-preset-button'),
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

            _clearInput();
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
      final PresetCard card = PresetCard(preset: preset);
      presetCards.add(card);
    }

    return presetCards;
  }

  void _updateDeskName() {
    setState(() {
      newDesk = newDesk.copyWith(name: deskNameController.text);
    });
  }

  void _updateDeskHeight(double newHeight) {
    setState(() {
      newDesk = newDesk.copyWith(
        height: newHeight,
      );
    });
  }

  void _clearInput() {
    setState(() {
      newDesk = Desk.empty();

      deskNameController.clear();
      deskHeightController.text = newDesk.height.toStringAsFixed(2);
    });
  }
}
