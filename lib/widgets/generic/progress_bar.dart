import 'package:deskify/utils.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double height;
  final double displayValue;
  final Color displayColor;

  const ProgressBar({
    required this.height,
    required this.displayValue,
    this.displayColor = Colors.white,
    super.key,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildProgressBar(),
        const SizedBox(height: 10.0),
        Center(child: _buildSemanticsLabel()),
      ],
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: LinearProgressIndicator(
          value: widget.displayValue,
          valueColor: AlwaysStoppedAnimation<Color>(widget.displayColor),
        ),
      ),
    );
  }

  Widget _buildSemanticsLabel() {
    return Text(
      "${Utils.roundDouble(widget.displayValue * 100, 1)}% completed",
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
