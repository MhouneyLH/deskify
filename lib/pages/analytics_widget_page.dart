import 'package:deskify/model/profile.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/progress_bar.dart';
import 'package:flutter/material.dart';

class AnalyticsWidgetPage extends StatefulWidget {
  Target target;
  final Color signalizationColor;

  AnalyticsWidgetPage({
    required this.target,
    this.signalizationColor = Colors.blue,
    super.key,
  });

  @override
  State<AnalyticsWidgetPage> createState() => _AnalyticsWidgetPageState();
}

class _AnalyticsWidgetPageState extends State<AnalyticsWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressBar(
            height: 20.0,
            displayValue: widget.target.actualValue /
                Utils.hoursToSeconds(widget.target.targetValue),
            displayColor: widget.signalizationColor,
          ),
          Text(
            "Actual: ${Utils.secondsToHours(widget.target.actualValue.toInt())} h",
            style: const TextStyle(fontSize: 20.0),
          ),
          Text(
            "Target: ${widget.target.targetValue} h",
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Back"),
            ),
          ),
        ],
      ),
    );
  }
}
