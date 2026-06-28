import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltwatch/core/services/notification_service.dart';
import 'package:voltwatch/core/services/workmanager_service.dart';
import 'package:workmanager/workmanager.dart';
import 'core/services/storage_service.dart';
import 'presentation/screens/dashboard_screen.dart';

void main() async {
  // Required before using async plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await StorageService.init();
  await NotificationService.init();

  await Workmanager().initialize(callbackDispatcher);

  await Workmanager().registerPeriodicTask(
    "batteryTrackingTask",
    "batteryTrackingTask",
    frequency: Duration(minutes: 15),
  );

  // Start app with Riverpod scope
  runApp(const ProviderScope(child: VoltWatchApp()));
}

/// Root widget of VoltWatch app
class VoltWatchApp extends StatelessWidget {
  const VoltWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoltWatch',

      // Hide debug banner
      debugShowCheckedModeBanner: false,

      // Starting screen
      home: DashboardScreen(),
    );
  }
}
