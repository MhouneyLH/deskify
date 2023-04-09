import 'package:deskify/provider/desk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = "Deskify";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeskProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
