import 'package:flutter/material.dart';

/// Returns battery color based on battery level
class BatteryColorHelper {
  static Color getColor(int level) {
    // Battery between 80–100
    if (level >= 80) {
      return Colors.green;
    }

    // Battery between 40–79
    if (level >= 40) {
      return Colors.yellow;
    }

    // Battery below 40
    return Colors.red;
  }
}