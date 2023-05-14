import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/interaction_widget_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Deskify';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
            useMaterial3: true,
            colorScheme: themeProvider.themeData.colorScheme,
            textTheme: themeProvider.themeData.textTheme,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
