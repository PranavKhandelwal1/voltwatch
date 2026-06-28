import 'package:flutter/material.dart';
import '../../core/utils/battery_color_helper.dart';

/// Modern glowing battery gauge
class BatteryGauge extends StatelessWidget {
  final int batteryLevel;

  const BatteryGauge({
    super.key,
    required this.batteryLevel,
  });

  @override
  Widget build(BuildContext context) {
    final batteryColor =
    BatteryColorHelper.getColor(batteryLevel);

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: batteryColor.withOpacity(0.35),
            blurRadius: 35,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0,
              end: batteryLevel / 100,
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return SizedBox(
                width: 220,
                height: 220,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 16,
                  color: batteryColor,
                  backgroundColor:
                  Colors.white.withOpacity(0.2),
                ),
              );
            },
          ),

          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                Icons.battery_charging_full,
                size: 50,
                color: batteryColor,
              ),
              const SizedBox(height: 10),
              Text(
                "$batteryLevel%",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}