import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltwatch/core/services/alert_service.dart';
import 'package:voltwatch/core/services/notification_service.dart';
import 'package:voltwatch/data/models/battery_log_model.dart';
import 'package:voltwatch/presentation/screens/analytics_screen.dart';
import 'package:voltwatch/presentation/screens/settings_screen.dart';
import 'package:voltwatch/presentation/viewmodels/settings_provider.dart';
import '../../core/services/background_service.dart';
import '../viewmodels/battery_provider.dart';
import '../widgets/battery_gauge.dart';
import '../viewmodels/log_provider.dart';

/// Main dashboard screen
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryLevel = ref.watch(batteryLevelStreamProvider);
    final batteryState = ref.watch(batteryStateStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("VoltWatch"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 30),

          // 1. Battery percentage UI
          batteryLevel.when(
            data: (level) {
              final threshold = ref.watch(batteryThresholdProvider);

              // Notification logic
              if (AlertService.canNotify(level, threshold)) {
                NotificationService.showBatteryAlert(level);
              }

              return Center(child: BatteryGauge(batteryLevel: level));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text(error.toString())),
          ),

          const SizedBox(height: 40),

          // 2. Battery charging/discharging state UI
          batteryState.when(
            data: (state) => Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text("Battery State"),
                    const SizedBox(height: 10),
                    Text(state.name.toUpperCase()),
                  ],
                ),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text(error.toString())),
          ),

          const SizedBox(height: 20),


          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
              );
            },
            icon: const Icon(Icons.analytics),
            label: const Text("View Analytics"),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings),
            label: const Text("Battery Alert Settings"),
          ),
          ElevatedButton(
            onPressed: () async {
              await BackgroundService.executeTask();
            },
            child: const Text("Run Background Test"),
          ),
        ],
      ),
    );
  }
}
