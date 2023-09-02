import 'package:flutter/material.dart';

class MoveDeskPage extends StatefulWidget {
  const MoveDeskPage({super.key});

  @override
  State<MoveDeskPage> createState() => _MoveDeskPageState();
}

class _MoveDeskPageState extends State<MoveDeskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move Desk Page'),
      ),
      body: const Placeholder(),
    );
  }
}
