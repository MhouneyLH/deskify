import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

import 'features/presentation/bloc/desk/desk_bloc.dart';
import 'injection_container.dart' as injection_container;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await injection_container.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => injection_container.sl<DeskBloc>()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Deskify';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: MainApp.title,
      // theme: ThemeData.from(
      //   useMaterial3: true, // for a more modern look
      //   colorScheme: themeProvider.themeData.colorScheme,
      //   textTheme: themeProvider.themeData.textTheme,
      // ),
      home: App(),
    );
  }
}
