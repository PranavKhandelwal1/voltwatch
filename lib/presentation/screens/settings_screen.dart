import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../viewmodels/settings_provider.dart';

/// Allows user to set custom battery alert threshold
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threshold = ref.watch(
      batteryThresholdProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Set Battery Alert Threshold",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "$threshold%",
              style: const TextStyle(
                fontSize: 28,
              ),
            ),

            Slider(
              min: 1,
              max: 100,
              value: threshold.toDouble(),
              divisions: 99,
              label: threshold.toString(),
              onChanged: (value) {
                ref
                    .read(
                      batteryThresholdProvider.notifier,
                    )
                    .state = value.toInt();
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final settingsBox = Hive.box('settings');

                await settingsBox.put(
                  'threshold',
                  threshold,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Threshold saved",
                    ),
                  ),
                );
              },
              child: const Text(
                "Save Threshold",
              ),
            ),
          ],
        ),
      ),
    );
  }
}