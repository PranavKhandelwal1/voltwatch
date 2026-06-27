import 'package:hive/hive.dart';

/// Generated file for Hive adapter
part 'battery_log_model.g.dart';

/// Battery log model stored locally in Hive
@HiveType(typeId: 0)
class BatteryLog extends HiveObject {
  /// Battery percentage (0–100)
  @HiveField(0)
  final int batteryLevel;

  /// Current battery state (charging, discharging, full, etc.)
  @HiveField(1)
  final String batteryState;

  /// Time when this battery log was recorded
  @HiveField(2)
  final DateTime timestamp;

  BatteryLog({
    required this.batteryLevel,
    required this.batteryState,
    required this.timestamp,
  });
}