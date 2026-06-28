import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/alert_service.dart';
import '../../core/services/notification_service.dart';
import '../viewmodels/battery_provider.dart';
import '../viewmodels/settings_provider.dart';
import '../widgets/battery_gauge.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryLevel =
    ref.watch(batteryLevelStreamProvider);

    final batteryState =
    ref.watch(batteryStateStreamProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "VoltWatch",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            /// Battery Gauge
            batteryLevel.when(
              data: (level) {
                final threshold =
                ref.watch(
                  batteryThresholdProvider,
                );

                if (AlertService.canNotify(
                    level, threshold)) {
                  NotificationService
                      .showBatteryAlert(level);
                }

                return Center(
                  child: BatteryGauge(
                    batteryLevel: level,
                  ),
                );
              },
              loading: () =>
              const Center(
                child:
                CircularProgressIndicator(),
              ),
              error: (error, stack) =>
                  Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
            ),

            const SizedBox(height: 30),

            /// Status Chips
            batteryState.when(
              data: (state) => Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment:
                WrapAlignment.center,
                children: [
                  Chip(
                    avatar: const Icon(
                      Icons.bolt,
                      color: Colors.yellow,
                    ),
                    label: Text(
                      state.name.toUpperCase(),
                    ),
                  ),
                  const Chip(
                    avatar: Icon(
                      Icons.health_and_safety,
                      color: Colors.green,
                    ),
                    label: Text("Healthy"),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.notifications,
                      color: Colors.red,
                    ),
                    label: Text(
                      "Threshold ${ref.watch(batteryThresholdProvider)}%",
                    ),
                  ),
                ],
              ),
              loading: () =>
              const Center(
                child:
                CircularProgressIndicator(),
              ),
              error: (error, stack) =>
                  Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
            ),

            const SizedBox(height: 30),

            /// Navigation Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AnalyticsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.analytics,
                    ),
                    label:
                    const Text("Analytics"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const SettingsScreen(),
                        ),
                      );
                    },
                    icon:
                    const Icon(Icons.settings),
                    label:
                    const Text("Settings"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(
                    batteryLevelStreamProvider);
                ref.invalidate(
                    batteryStateStreamProvider);
              },
              icon: const Icon(Icons.refresh),
              label:
              const Text("Refresh Battery"),
            ),
          ],
        ),
      ),
    );
  }
}