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
    return _buildProgressBar();
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

  
}
