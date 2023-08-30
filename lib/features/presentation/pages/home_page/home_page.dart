import 'package:deskify/features/presentation/pages/home_page/desk_interaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/desk.dart';
import '../../../domain/entities/preset.dart';
import '../../bloc/desk/desk_bloc.dart';
import '../../themes/theme.dart';
import 'desk_carousel_slider.dart';
import '../../widgets/widgets.dart';

/// A page on which the user gets an overview of all [Desk] entities and
/// possibilities to interact with them. (e. g. select a desk, move the desk, tap on a preset, add a preset, etc.)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<DeskBloc>(context).add(GotAllDesks());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCurrentDeskHeading(),
        const SizedBox(height: ThemeSettings.smallSpacing),
        _buildCurrentDeskHeightText(),
        const SizedBox(height: ThemeSettings.largeSpacing),
        _buildDeskCarouselSlider(),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(title: 'Analytics'),
        const SizedBox(height: ThemeSettings.smallSpacing),
        DeskInteractionCard(
          title: 'Standing Time',
          iconAtStart: const Icon(Icons.info),
          onPressedCard: () {},
          child: const LinearProgressIndicator(
            value: 0.7,
          ),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        DeskInteractionCard(
          title: 'Sitting Time',
          iconAtStart: const Icon(Icons.info),
          onPressedCard: () {},
          child: const LinearProgressIndicator(
            value: 0.3,
          ),
        ),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(title: 'Presets'),
        const SizedBox(height: ThemeSettings.smallSpacing),
        _buildCurrentDeskPresets(),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(title: 'Others'),
        const SizedBox(height: ThemeSettings.smallSpacing),
        DeskInteractionCard(
          title: 'Move desk',
          iconAtStart: const Icon(Icons.move_up),
          onPressedCard: () {},
        ),
      ],
    );
  }

  Widget _buildCurrentDeskHeading() {
    return BlocBuilder<DeskBloc, DeskState>(
      buildWhen: (previous, current) => current is UpdateCurrentDeskSuccess,
      builder: (context, state) {
        if (state is Empty) {
          return const Text('');
        } else if (state is UpdateCurrentDeskSuccess) {
          return Heading(title: state.currentDesk.name);
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _buildCurrentDeskHeightText() {
    return BlocBuilder<DeskBloc, DeskState>(
      buildWhen: (previous, current) => current is UpdateCurrentDeskSuccess,
      builder: (context, state) {
        if (state is Empty) {
          return const Text('');
        } else if (state is UpdateCurrentDeskSuccess) {
          return Text('${state.currentDesk.height.toString()} cm');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _buildCurrentDeskPresets() {
    return BlocBuilder<DeskBloc, DeskState>(
      buildWhen: (previous, current) => current is UpdateCurrentDeskSuccess,
      builder: (context, state) {
        if (state is Empty) {
          return const Text('');
        } else if (state is UpdateCurrentDeskSuccess) {
          return Column(
            children: [
              for (final Preset preset in state.currentDesk.presets)
                Column(
                  children: [
                    DeskInteractionCard(
                      title: preset.name,
                      iconAtStart: const Icon(Icons.info),
                      onPressedCard: () {},
                      iconAtEnd: const Icon(Icons.settings),
                      onPressedIconAtEnd: () {},
                      child: Text('${preset.targetHeight.toString()} cm'),
                    ),
                    const SizedBox(height: ThemeSettings.smallSpacing),
                  ],
                ),
            ],
          );
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _buildDeskCarouselSlider() {
    return BlocBuilder<DeskBloc, DeskState>(
      buildWhen: (previous, current) =>
          current is GetAllDesksFetching ||
          current is GetAllDesksSuccess ||
          current is GetAllDesksFailure,
      builder: (context, state) {
        if (state is Empty) {
          return const Text('');
        } else if (state is GetAllDesksFetching) {
          return const LoadingIndicator();
        } else if (state is GetAllDesksSuccess) {
          if (state.desks.isEmpty) {
            _updateCurrentDesk(Desk.empty());
            return const Text('No desks found');
          }

          _updateCurrentDesk(state.desks.first);

          return DeskCarouselSlider(
            allDesks: state.desks,
            onDeskSelected: (Desk desk) => _updateCurrentDesk(desk),
          );
        } else if (state is GetAllDesksFailure) {
          return Column(
            children: [
              const Icon(Icons.error),
              Text(state.message),
            ],
          );
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  void _updateCurrentDesk(Desk desks) {
    BlocProvider.of<DeskBloc>(context).add(
      UpdatedCurrentDesk(
        // TODO: hier wird gerade wie beim CarouselSLider einfach erstmal das 0.te Element verwendet
        //       -> später mal schauen, wie ich das in der DB abbilden kann
        currentDesk: desks,
      ),
    );
  }
}
