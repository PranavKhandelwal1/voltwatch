import 'package:battery_plus/battery_plus.dart';

/// Handles battery-related native operations
class BatteryService {
  final Battery _battery = Battery();

  /// Fetch current battery percentage
  Future<int> getBatteryLevel() async {
    return await _battery.batteryLevel;
  }

  /// Fetch current battery state
  Future<BatteryState> getBatteryState() async {
    return await _battery.batteryState;
  }

  /// Listen to battery state changes in real-time
  Stream<BatteryState> batteryStateStream() {
    return _battery.onBatteryStateChanged;
  }
}