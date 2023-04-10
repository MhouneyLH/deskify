import 'package:deskify/widgets/generic/progress_bar.dart';
import 'package:flutter/material.dart';

class AnalyticsWidgetPage extends StatefulWidget {
  final Color signalizationColor;

  const AnalyticsWidgetPage({
    required this.signalizationColor,
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
            displayValue: 0.5,
            displayColor: widget.signalizationColor,
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
