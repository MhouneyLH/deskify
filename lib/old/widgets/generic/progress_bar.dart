import 'dart:async';

import 'package:flutter/material.dart';

import '../../model/target.dart';

// a progress bar that shows the progress of a target
class ProgressBar extends StatefulWidget {
  final double height;
  final TimeTarget target;
  final Color displayColor;

  const ProgressBar({
    required this.height,
    required this.target,
    this.displayColor = Colors.white,
    super.key,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late Timer _updateTimer;
  late double _progress;

  @override
  void initState() {
    super.initState();

    _progress =
        widget.target.actualValueInSeconds / widget.target.targetValueInSeconds;
    _updateTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _updateProgress(),
    );
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: LinearProgressIndicator(
          value: _progress,
          valueColor: AlwaysStoppedAnimation<Color>(widget.displayColor),
        ),
      ),
    );
  }

  void _updateProgress() {
    setState(() {
      _progress = widget.target.actualValueInSeconds /
          widget.target.targetValueInSeconds;
    });
  }
}
