import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/battery_log_model.dart';

/// Displays battery history as line chart
class BatteryChart extends StatelessWidget {
  final List<BatteryLog> logs;

  const BatteryChart({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: 100,

            borderData: FlBorderData(
              show: true,
            ),

            gridData: FlGridData(
              show: true,
              horizontalInterval: 20,
            ),

            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 20,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      "${value.toInt()}%",
                    );
                  },
                ),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                    );
                  },
                ),
              ),

              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),

              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  logs.length,
                      (index) => FlSpot(
                    index.toDouble(),
                    logs[index].batteryLevel.toDouble(),
                  ),
                ),
                isCurved: true,
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}