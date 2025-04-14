import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLine extends StatelessWidget {
  final int viewIndex;
  const ChartLine({super.key, required this.viewIndex});

  List<FlSpot> getChartData() {
    switch (viewIndex) {
      case 0: // Day
        return [
          const FlSpot(0, 2000),
          const FlSpot(1, 4000),
          const FlSpot(2, 4200),
          const FlSpot(3, 7000),
          const FlSpot(4, 5000),
          const FlSpot(5, 6000),
          const FlSpot(6, 7000),
        ];
      case 1: // Week
        return [
          const FlSpot(0, 15000),
          const FlSpot(1, 18000),
          const FlSpot(2, 22000),
          const FlSpot(3, 25000),
        ];
      case 2: // Month
        return [
          const FlSpot(0, 70000),
          const FlSpot(1, 75000),
          const FlSpot(2, 80000),
          const FlSpot(3, 90000),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  switch (viewIndex) {
                    case 0:
                      const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                      return Text(days[value.toInt()]);
                    case 1:
                      const weeks = ['W1', 'W2', 'W3', 'W4'];
                      return Text(weeks[value.toInt()]);
                    case 2:
                      const months = ['Jan', 'Feb', 'Mar', 'Apr'];
                      return Text(months[value.toInt()]);
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getChartData(),
              isCurved: true,
              color: Colors.blue,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.2),
              ),
              dotData: FlDotData(show: false),
              barWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
