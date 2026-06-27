import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      body: logs.isEmpty
          ? const Center(
              child: Text(
                "No battery logs available",
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return LogTile(
                  log: logs[index],
                );
              },
            ),
    );
  }
}