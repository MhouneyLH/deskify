import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'provider/desk_provider.dart';
import 'provider/interaction_widget_provider.dart';
import 'provider/profile_provider.dart';
import 'provider/theme_provider.dart';

// entry point of the app
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

// root widget of the app
// connection between the app and the providers
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Deskify';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // initialize all available providers
      providers: [
        ChangeNotifierProvider(create: (_) => DeskProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => InteractionWidgetProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: MainApp.title,
          theme: ThemeData.from(
            useMaterial3: true, // for a more modern look
            colorScheme: themeProvider.themeData.colorScheme,
            textTheme: themeProvider.themeData.textTheme,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
