import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/battery_log_model.dart';
import 'background_service.dart';

/// Background task entry point
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Hive
    await Hive.initFlutter();

    Hive.registerAdapter(
      BatteryLogAdapter(),
    );

    await Hive.openBox<BatteryLog>(
      'battery_logs',
    );

    await Hive.openBox('settings');

    // Run background battery logging
    await BackgroundService.executeTask();

    return Future.value(true);
  });
}