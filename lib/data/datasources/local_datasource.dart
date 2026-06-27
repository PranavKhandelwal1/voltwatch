import 'package:hive/hive.dart';
import '../models/battery_log_model.dart';

/// Handles local database operations
class LocalDataSource {
  final Box<BatteryLog> batteryBox =
      Hive.box<BatteryLog>('battery_logs');

  /// Save battery log
  Future<void> saveBatteryLog(BatteryLog log) async {
    await batteryBox.add(log);
  }

  /// Fetch all battery logs
  List<BatteryLog> getBatteryLogs() {
    return batteryBox.values.toList();
  }

  /// Delete all logs (for testing/debugging)
  Future<void> clearLogs() async {
    await batteryBox.clear();
  }
}