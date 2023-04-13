import 'package:deskify/model/profile.dart';
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
          const SizedBox(height: 10.0),
          SizedBox(
            height: 300.0,
            child: _buildBarChart(widget.targetWeekdayMap),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(Map<int, Target> targetWeekdayMap) {
    return BarChart(
      BarChartData(
        barGroups: targetWeekdayMap.entries
            .map(
              (MapEntry<int, Target> entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    fromY: 0.0,
                    toY:
                        Utils.secondsToMinutes(entry.value.actualValue.toInt()),
                    width: 15.0,
                  ),
                  BarChartRodData(
                    fromY: 0.0,
                    toY: entry.value.targetValue,
                    width: 15.0,
                    color: Colors.amber,
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            )
            .toList(),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            axisNameSize: 12,
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                "${value.toInt()}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            axisNameWidget: const Text(
              "min",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            axisNameSize: 12,
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                _getWeekdayByInt(value.toInt()),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
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

  String _getWeekdayByInt(int dayAsInt) {
    switch (dayAsInt) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "Mon";
    }
  }
}
