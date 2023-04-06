import 'package:deskify/widgets/adjust_height_slider.dart';
import 'package:flutter/material.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  double _currentDeskHeight = 72.0;

  void _updateCurrentDeskHeight(double value) {
    setState(() {
      _currentDeskHeight = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("HomePageTab"),
          Text("Height: $_currentDeskHeight"),
          AdjustHeightSlider(
            onValueChanged: _updateCurrentDeskHeight,
          ),
        ],
      ),
    );
  }
}
