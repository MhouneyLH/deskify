import 'package:deskify/model/desk.dart';
import 'package:deskify/widgets/adjust_height_slider.dart';
import 'package:flutter/material.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  final Desk _currentDesk = Desk();

  void _updateCurrentDeskHeight(double value) {
    setState(() {
      _currentDesk.height = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("HomePageTab"),
          Text("${_currentDesk.name}"),
          Text("Height: ${_currentDesk.height} cm"),
          AdjustHeightSlider(
            onValueChanged: _updateCurrentDeskHeight,
          ),
        ],
      ),
    );
  }
}
