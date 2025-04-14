import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final int viewIndex;
  const ChartBar({super.key, required this.viewIndex});

  List<double> getBarData() {
    switch (viewIndex) {
      case 0:
        return [300, 400, 500, 450, 300, 600, 500];
      case 1:
        return [2100, 2500, 3000, 3300];
      case 2:
        return [8000, 8800, 9200, 10000];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = getBarData();

    return SizedBox(
      height: 150,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(data.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data[index],
                  color: Colors.blue,
                  width: 16,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
