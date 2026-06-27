import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/battery_log_model.dart';

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BatteryLogAdapter());

    await Hive.openBox<BatteryLog>('battery_logs');
    await Hive.openBox('settings');
  }
}