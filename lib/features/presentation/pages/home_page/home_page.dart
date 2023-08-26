import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/desk.dart';
import '../../../domain/entities/preset.dart';
import '../../bloc/desk/desk_bloc.dart';
import 'desk_carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DeskBloc, DeskState>(
          buildWhen: (previous, current) => current is UpdateCurrentDeskSuccess,
          builder: (context, state) {
            if (state is Empty) {
              return const Text('Current desk: Empty');
            } else if (state is UpdateCurrentDeskSuccess) {
              return Text('Current desk: ${state.currentDesk}');
            } else {
              return const Text('Unknown state');
            }
          },
        ),
        const SizedBox(width: 10.0),
        //! TEST PART
        ElevatedButton(
          onPressed: () => BlocProvider.of<DeskBloc>(context).add(
            DeletedDesk(id: BlocProvider.of<DeskBloc>(context).currentDesk.id),
          ),
          child: const Text('Delete Desk'),
        ),
        BlocBuilder<DeskBloc, DeskState>(
          buildWhen: (previous, current) =>
              current is DeleteDeskFetching ||
              current is DeleteDeskSuccess ||
              current is DeleteDeskFailure,
          builder: (context, state) {
            if (state is Empty) {
              return const Text('Empty');
            } else if (state is DeleteDeskFetching) {
              return const CircularProgressIndicator();
            } else if (state is DeleteDeskSuccess) {
              return const Text('Deleting worked fine :)');
            } else if (state is DeleteDeskFailure) {
              return Text(state.message);
            } else {
              return const Text('Unknown state');
            }
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () => BlocProvider.of<DeskBloc>(context).add(
                  CreatedDesk(
                    desk: Desk(
                      height: 100.1,
                      name: 'This is my desk',
                      presets: const [
                        Preset(
                          id: '0',
                          name: 'preset 1',
                          targetHeight: 88.8,
                        ),
                        Preset(
                          id: '1',
                          name: 'preset 2',
                          targetHeight: 102.1,
                        ),
                      ],
                    ),
                  ),
                ),
            child: const Text('Create Desk')),
        const SizedBox(height: 20),
        BlocBuilder<DeskBloc, DeskState>(
          buildWhen: (previous, current) =>
              current is CreateDeskFetching ||
              current is CreateDeskSuccess ||
              current is CreateDeskFailure,
          builder: (context, state) {
            if (state is Empty) {
              return const Text('Empty');
            } else if (state is CreateDeskFetching) {
              return const CircularProgressIndicator();
            } else if (state is CreateDeskSuccess) {
              return const Text('This worked :)');
            } else if (state is CreateDeskFailure) {
              return Text(state.message);
            } else {
              return const Text('Unknown state');
            }
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () =>
              BlocProvider.of<DeskBloc>(context).add(GotAllDesks()),
          child: const Text('Get all desks'),
        ),
        const SizedBox(height: 20),
        BlocBuilder<DeskBloc, DeskState>(
          buildWhen: (previous, current) =>
              current is GetAllDesksFetching ||
              current is GetAllDesksSuccess ||
              current is GetAllDesksFailure,
          builder: (context, state) {
            if (state is Empty) {
              return const Text('Empty');
            } else if (state is GetAllDesksFetching) {
              return const CircularProgressIndicator();
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
        ),
      ],
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
