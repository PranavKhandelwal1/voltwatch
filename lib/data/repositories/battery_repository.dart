import '../datasources/local_datasource.dart';
import '../models/battery_log_model.dart';

/// Repository layer between UI and data source
class BatteryRepository {
  final LocalDataSource localDataSource = LocalDataSource();

  /// Save new battery log
  Future<void> saveLog(BatteryLog log) async {
    await localDataSource.saveBatteryLog(log);
  }

  /// Get all saved logs
  List<BatteryLog> getLogs() {
    return localDataSource.getBatteryLogs();
  }

  /// Clear logs
  Future<void> clearLogs() async {
    await localDataSource.clearLogs();
  }
}