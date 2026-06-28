import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../../data/models/battery_log_model.dart';
import '../viewmodels/log_provider.dart';
import '../widgets/battery_chart.dart';
import '../widgets/log_tile.dart';

/// Displays saved battery history
class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(batteryLogsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Battery Analytics"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(
                batteryRepositoryProvider,
              ).clearLogs();

              ref.read(
                batteryLogsProvider.notifier,
              ).state = [];

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("All logs deleted"),
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<BatteryLog>('battery_logs').listenable(),
        builder: (context, box, child) {
          final highest = logs.isEmpty
              ? 0
              : logs
              .map((e) => e.batteryLevel)
              .reduce((a, b) => a > b ? a : b);

          final lowest = logs.isEmpty
              ? 0
              : logs
              .map((e) => e.batteryLevel)
              .reduce((a, b) => a < b ? a : b);

          final average = logs.isEmpty
              ? 0
              : logs
              .map((e) => e.batteryLevel)
              .reduce((a, b) => a + b) ~/
              logs.length;

          if (logs.isEmpty) {
            return const Center(
              child: Text("No battery logs available"),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text("Highest: $highest%"),
                      Text("Lowest: $lowest%"),
                      Text("Average: $average%"),
                      Text("Total Logs: ${logs.length}"),
                    ],
                  ),
                ),
              ),
              // Chart section
              BatteryChart(
                logs: logs,
              ),

              const SizedBox(height: 20),

              // Logs list
              ...logs.map(
                    (log) => LogTile(
                  log: log,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}