import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  final Battery _battery = Battery();

  Future<int> getBatteryLevel() async {
    return await _battery.batteryLevel;
  }

  Future<BatteryState> getBatteryState() async {
    return await _battery.batteryState;
  }

  Stream<BatteryState> batteryStateStream() {
    return _battery.onBatteryStateChanged;
  }
}