import 'package:battery_plus/battery_plus.dart';
import 'package:hive/hive.dart';
import '../../data/models/battery_log_model.dart';
import 'notification_service.dart';
import 'alert_service.dart';

/// Handles background battery logging
class BackgroundService {
  static Future<void> executeTask() async {
    final battery = Battery();
    print("Background task started");
    // Fetch battery data
    final level = await battery.batteryLevel;
    final state = await battery.batteryState;

    print("Battery Level: $level");
    print("Battery State: ${state.name}");
    // Save to Hive
    final batteryBox = Hive.box<BatteryLog>('battery_logs');
    print("Box opened successfully");
    print("Saving battery log...");
    await batteryBox.add(
      BatteryLog(
        batteryLevel: level,
        batteryState: state.name,
        timestamp: DateTime.now(),
      ),
    );
    print("Battery log saved successfully");
    // Read threshold
    final settingsBox = Hive.box('settings');
    final threshold = settingsBox.get('threshold', defaultValue: 80);

    // Trigger alert
    if (AlertService.canNotify(level, threshold)) {
      await NotificationService.showBatteryAlert(level);
    }

    print("Total logs: ${batteryBox.length}");
  }
}
