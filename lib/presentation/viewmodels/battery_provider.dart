import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/battery_service.dart';

final batteryServiceProvider = Provider((ref) => BatteryService());

final batteryLevelProvider = FutureProvider<int>((ref) async {
  return ref.read(batteryServiceProvider).getBatteryLevel();
});

final batteryStateProvider = FutureProvider((ref) async {
  return ref.read(batteryServiceProvider).getBatteryState();
});