import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'features/presentation/bloc/desk/desk_bloc.dart';
import 'features/presentation/themes/theme.dart';
import 'injection_container.dart' as injection_container;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await injection_container.init();

  // TODO: maybe this should be moved in injection_container.dart???
  Bloc.observer = injection_container.sl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injection_container.sl<DeskBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Deskify';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MainApp.title,
      themeMode: ThemeMode.system,
      theme: ThemeSettings.lightTheme,
      darkTheme: ThemeSettings.darkTheme,
      home: const App(),
    );
  }
}
