import 'package:deskify/features/domain/entities/desk.dart';
import 'package:deskify/features/domain/entities/preset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/bloc/desk/desk_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => BlocProvider.of<DeskBloc>(context)
                .add(const DeletedDesk(id: '1E3cO77zZdq7DPMuZk77')),
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
                List<Column> columns = [];
                for (final desk in state.desks) {
                  columns.add(Column(
                    children: [
                      Text(desk.id),
                      Text(desk.name),
                      Text(desk.height.toString()),
                      for (final preset in desk.presets) Text(preset.name),
                      const SizedBox(height: 20),
                    ],
                  ));
                }

                return columns.isNotEmpty
                    ? Column(children: columns)
                    : const Text('No desks found');
              } else if (state is GetAllDesksFailure) {
                return Text(state.message);
              } else {
                return const Text('Unknown state');
              }
            },
          ),
        ],
      )),
    );
  }
}
