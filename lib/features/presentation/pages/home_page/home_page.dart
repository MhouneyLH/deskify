import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/desk.dart';
import '../../../domain/entities/preset.dart';
import '../../bloc/desk/desk_bloc.dart';
import '../../themes/theme.dart';
import '../../widgets/widgets.dart';
import 'desk_carousel_slider.dart';
import 'desk_interaction_card.dart';

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
        const Heading(
          key: Key('analytics-heading'),
          title: 'Analytics',
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        DeskInteractionCard(
          key: const Key('analytics-desk-card-standing'),
          title: 'Standing Time',
          iconAtStart: const Icon(Icons.info),
          onPressedCard: () {},
          child: const LinearProgressIndicator(
            value: 0.7,
          ),
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        DeskInteractionCard(
          key: const Key('analytics-desk-card-sitting'),
          title: 'Sitting Time',
          iconAtStart: const Icon(Icons.info),
          onPressedCard: () {},
          child: const LinearProgressIndicator(
            value: 0.3,
          ),
        ),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(
          key: Key('preset-heading'),
          title: 'Presets',
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        _buildCurrentDeskPresets(),
        const SizedBox(height: ThemeSettings.mediumSpacing),
        const Heading(
          key: Key('others-heading'),
          title: 'Others',
        ),
        const SizedBox(height: ThemeSettings.smallSpacing),
        DeskInteractionCard(
          key: const Key('others-desk-card-move'),
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
          return Container();
        } else if (state is UpdateCurrentDeskSuccess) {
          return Heading(
            key: const Key('current-desk-name'),
            title: state.currentDesk.name,
          );
        } else if (state is UpdateCurrentDeskFailure) {
          return Container();
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _buildCurrentDeskHeightText() {
    return BlocBuilder<DeskBloc, DeskState>(
      buildWhen: (previous, current) =>
          current is UpdateCurrentDeskSuccess ||
          current is UpdateCurrentDeskFailure,
      builder: (context, state) {
        if (state is Empty) {
          return Container();
        } else if (state is UpdateCurrentDeskSuccess) {
          return Text(
            '${state.currentDesk.height.toStringAsFixed(2)} cm',
            key: const Key('current-desk-height'),
          );
        } else if (state is UpdateCurrentDeskFailure) {
          return Container();
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _buildCurrentDeskPresets() {
    return BlocBuilder<DeskBloc, DeskState>(
      buildWhen: (previous, current) =>
          current is UpdateCurrentDeskSuccess ||
          current is UpdateCurrentDeskFailure,
      builder: (context, state) {
        if (state is Empty) {
          return Container();
        } else if (state is UpdateCurrentDeskSuccess) {
          final List<DeskInteractionCard> cards =
              _getAllPresetDeskInteractionCards(state.currentDesk.presets);

          return ListView.separated(
            key: const Key('preset-desk-card-list'),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: ThemeSettings.smallSpacing);
            },
            itemCount: cards.length,
            itemBuilder: (_, index) {
              return cards[index];
            },
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
          return Container();
        } else if (state is GetAllDesksFetching) {
          return const LoadingIndicator(
            key: Key('all-desks-loading-indicator'),
          );
        } else if (state is GetAllDesksSuccess) {
          if (state.desks.isEmpty) {
            _updateCurrentDesk(Desk.empty());
            return const Center(child: Text('No desks found :/'));
          }

          // TODO: hier wird gerade wie beim CarouselSlider einfach erstmal das 0.te Element verwendet
          //       -> später mal schauen, wie ich das in der DB abbilden kann
          _updateCurrentDesk(state.desks.first);

          return DeskCarouselSlider(
            key: const Key('desk-carousel-slider'),
            allDesks: state.desks,
            onDeskSelected: (Desk desk) => _updateCurrentDesk(desk),
          );
        } else if (state is GetAllDesksFailure) {
          return Column(
            key: const Key('all-desks-failure-column'),
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

  List<DeskInteractionCard> _getAllPresetDeskInteractionCards(
      List<Preset> presetList) {
    List<DeskInteractionCard> presetCards = [];

    for (final Preset preset in presetList) {
      final DeskInteractionCard card = DeskInteractionCard(
        key: Key('preset-desk-card-${preset.id}'),
        title: preset.name,
        iconAtStart: const Icon(Icons.height),
        onPressedCard: () {},
        iconAtEnd: const Icon(Icons.settings),
        onPressedIconAtEnd: () {},
        child: Text('${preset.targetHeight.toString()} cm'),
      );

      presetCards.add(card);
    }

    return presetCards;
  }

  void _updateCurrentDesk(Desk desk) {
    BlocProvider.of<DeskBloc>(context).add(
      UpdatedCurrentDesk(
        currentDesk: desk,
      ),
    );
  }
}
