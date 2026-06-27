import 'package:flutter/material.dart';
import '../../core/utils/battery_color_helper.dart';

/// Custom circular battery indicator widget
class BatteryGauge extends StatelessWidget {
  final int batteryLevel;

  const BatteryGauge({
    super.key,
    required this.batteryLevel,
  });

  @override
  Widget build(BuildContext context) {
    final batteryColor = BatteryColorHelper.getColor(batteryLevel);

    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated circular progress
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0,
              end: batteryLevel / 100,
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return CircularProgressIndicator(
                value: value,
                strokeWidth: 14,
              color: batteryColor,
                backgroundColor: Colors.grey.shade300,
              );
            },
          ),

          // Battery percentage text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.battery_full,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(
                "$batteryLevel%",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}