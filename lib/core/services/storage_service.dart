import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/battery_log_model.dart';

/// Handles local database initialization
class StorageService {
  static Future<void> init() async {
    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Register model adapter for BatteryLog
    Hive.registerAdapter(BatteryLogAdapter());

    // Open battery logs storage box
    await Hive.openBox<BatteryLog>('battery_logs');

    // Open settings storage box
    // This will store simple settings like battery threshold
    await Hive.openBox('settings');
  }
}