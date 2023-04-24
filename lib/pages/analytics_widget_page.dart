import 'package:deskify/model/target.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

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
  late ProfileProvider profileProvider;
  late Target target;
  late double progressValue;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    target = widget.targetWeekdayMap[Utils.getCurrentWeekdayAsInt()]!;
    progressValue = profileProvider.getProgress(target);

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
          Center(child: _buildSemanticsLabel(progressValue * 100)),
          const SizedBox(height: 60.0),
          SizedBox(
            height: 300.0,
            child: _buildBarChart(widget.targetWeekdayMap),
          ),
        ],
      ),
    );
  }

  Widget _buildSemanticsLabel(double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${Utils.roundDouble(value, 1)}% completed",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${Utils.secondsToMinutes(target.actualValue.toInt())} / ${target.targetValue} min",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(Map<int, Target> targetWeekdayMap) {
    return BarChart(
      BarChartData(
        barGroups: targetWeekdayMap.entries
            .map(
              (MapEntry<int, Target> entry) => _buildBarChartGroupData(entry),
            )
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
          // TODO: wtf does this do?
          checkToShowVerticalLine: (value) => value == 0,
        ),
      ),
    );
  }

  BarChartGroupData _buildBarChartGroupData(MapEntry<int, Target> entry) {
    return BarChartGroupData(
      x: entry.key,
      barRods: [
        BarChartRodData(
          fromY: 0.0,
          toY: Utils.secondsToMinutes(entry.value.actualValue.toInt()),
          width: 15.0,
          color: widget.signalizationColor,
        ),
        BarChartRodData(
          fromY: 0.0,
          toY: entry.value.targetValue,
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
          "${value.toInt()}",
        ),
      ),
      axisNameWidget: const Text(
        "min",
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
          Utils.intToShortWeekday(value.toInt()),
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
