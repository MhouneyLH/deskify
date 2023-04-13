import 'package:deskify/model/profile.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsWidgetPage extends StatefulWidget {
  final Map<int, Target> targetWeekdayMap;
  final Color signalizationColor;

  const AnalyticsWidgetPage({
    required this.targetWeekdayMap,
    this.signalizationColor = Colors.blue,
    super.key,
  });

  @override
  State<AnalyticsWidgetPage> createState() => _AnalyticsWidgetPageState();
}

class _AnalyticsWidgetPageState extends State<AnalyticsWidgetPage> {
  @override
  Widget build(BuildContext context) {
    final int weekdayAsInt = DateTime.now().weekday;
    final Target target = widget.targetWeekdayMap[weekdayAsInt]!;
    // TODO: Need this here to keep the build up to date
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressBar(
            height: 20.0,
            displayValue:
                target.actualValue / Utils.minutesToSeconds(target.targetValue),
            displayColor: widget.signalizationColor,
          ),
          Text(
            "Target today: ${target.targetValue} min",
            style: const TextStyle(fontSize: 20.0),
          ),
          Text(
            "Actual today: ${Utils.secondsToMinutes(target.actualValue.toInt())} min",
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
