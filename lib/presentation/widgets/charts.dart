import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 4),
            Expanded(
              child: BarChart(
                _mainBarData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(
      int x, double y, {bool isTouched = false}) {
    final barColor = isTouched ? Colors.green : Colors.blue;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: 22,
          borderSide: isTouched
              ? BorderSide(color: Colors.green.withOpacity(0.5))
              : BorderSide.none,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _showingGroups() {
    final values = [5.0, 6.5, 5.0, 7.5, 9.0, 11.5, 6.5];
    return List.generate(7, (i) => _makeGroupData(i, values[i]));
  }

  BarChartData _mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.black.withOpacity(0.7),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final weekDay = weekDays[group.x];
            return BarTooltipItem(
              '$weekDay\n${rod.toY.toStringAsFixed(1)}',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          // Handle touch interactions if needed
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: _getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: _showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget _getTitles(double value, TitleMeta meta) {
    final style = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final titles = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final text = Text(
      titles[value.toInt()],
      style: style,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
