import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/target.dart';
import '../provider/profile_provider.dart';
import '../utils.dart';
import '../widgets/generic/progress_bar.dart';
import '../widgets/generic/single_value_alert_dialog.dart';

// showing analytics of the current week (standing time, sitting time)
// todays progress is shown in a progress bar
// editable is:
// - target value
class AnalyticsWidgetPage extends StatefulWidget {
  final Map<int, TimeTarget> targetWeekdayMap;
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
  late ProfileProvider profileProvider;
  late TimeTarget target;
  late double progressValue;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    target = widget.targetWeekdayMap[Utils.getCurrentWeekdayAsInt()]!;
    progressValue = profileProvider.getTargetProgressAsPercent(target);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressBar(
            height: 20.0,
            target: target,
            displayColor: widget.signalizationColor,
          ),
          const SizedBox(height: 10.0),
          Center(child: _buildSemanticsLabel()),
          const SizedBox(height: 60.0),
          SizedBox(
            height: 300.0,
            child: _buildBarChart(widget.targetWeekdayMap),
          ),
        ],
      ),
    );
  }

  late TextEditingController targetValueController =
      TextEditingController(text: target.targetValueInSeconds.toString());

  Widget _buildSemanticsLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${Utils.roundDouble(profileProvider.getTargetProgressAsPercent(target) * 100, 1)}% completed',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => SingleValueAlertDialog(
              title: 'Set Target',
              controller: targetValueController,
              isNumericInput: true,
              onSave: () => target.targetValueInSeconds =
                  int.parse(targetValueController.text),
              onCancel: () => targetValueController.text =
                  target.targetValueInSeconds.toString(),
            ),
          ),
          child: Text(
            '${Utils.roundDouble(Utils.secondsToMinutes(target.actualValueInSeconds), 1)} / ${Utils.roundDouble(Utils.secondsToMinutes(target.targetValueInSeconds), 1)} min',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(Map<int, TimeTarget> targetWeekdayMap) {
    return BarChart(
      BarChartData(
        barGroups: targetWeekdayMap.entries
            .map((MapEntry<int, TimeTarget> entry) =>
                _buildBarChartGroupData(entry))
            .toList(),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: _buildLeftTitles(),
          topTitles: _buildEmptyTitles(),
          rightTitles: _buildEmptyTitles(),
          bottomTitles: _buildBottomTitles(),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(enabled: true),
        gridData: FlGridData(
          // shows a horizontal line for each value shown at the vertical axis
          checkToShowVerticalLine: (double value) => value == 0,
        ),
      ),
    );
  }

  BarChartGroupData _buildBarChartGroupData(MapEntry<int, TimeTarget> entry) {
    return BarChartGroupData(
      x: entry.key,
      // for each entry = weekday -> 7 pairs
      barRods: [
        // bar of the actual value
        BarChartRodData(
          fromY: 0.0,
          toY: Utils.secondsToMinutes(entry.value.actualValueInSeconds),
          width: 15.0,
          color: widget.signalizationColor,
        ),
        // bar of the target value
        BarChartRodData(
          fromY: 0.0,
          toY: Utils.secondsToMinutes(entry.value.targetValueInSeconds),
          width: 15.0,
          color: Theme.of(context).primaryColor,
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  AxisTitles _buildLeftTitles() {
    return AxisTitles(
      axisNameSize: 12,
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) => Text(
          '${value.toInt()}',
        ),
      ),
      axisNameWidget: const Text(
        'min',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AxisTitles _buildBottomTitles() {
    return AxisTitles(
      axisNameSize: 12,
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) => Text(
          Utils.intToThreeLetterWeekday(value.toInt()),
        ),
      ),
    );
  }

  AxisTitles _buildEmptyTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    );
  }
}
