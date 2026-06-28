import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../data/models/battery_log_model.dart';
import '../viewmodels/log_provider.dart';
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
          final logs = box.values.toList();

          if (logs.isEmpty) {
            return const Center(
              child: Text("No battery logs available"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return LogTile(
                log: logs[index],
              );
            },
          );
        },
      ),
    );
  }
}