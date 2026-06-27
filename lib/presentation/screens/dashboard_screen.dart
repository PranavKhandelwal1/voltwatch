import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/battery_provider.dart';
import '../widgets/battery_gauge.dart';

/// Main dashboard screen
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryLevel = ref.watch(batteryLevelStreamProvider);
    final batteryState = ref.watch(batteryStateStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("VoltWatch"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 30),

          // Live battery gauge
          batteryLevel.when(
            data: (level) => Center(
              child: BatteryGauge(
                batteryLevel: level,
              ),
            ),
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text(error.toString())),
          ),

          const SizedBox(height: 40),

          // Live battery state
          batteryState.when(
            data: (state) => Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      "Battery State",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text(error.toString())),
          ),

          const SizedBox(height: 30),

          // Manual refresh fallback
          ElevatedButton.icon(
            onPressed: () {
              ref.invalidate(batteryLevelStreamProvider);
              ref.invalidate(batteryStateStreamProvider);
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Refresh Now"),
          ),
        ],
      ),
    );
  }
}