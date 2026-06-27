import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/battery_service.dart';

/// Provides BatteryService instance globally
final batteryServiceProvider = Provider((ref) {
  return BatteryService();
});

/// Fetches battery level asynchronously
final batteryLevelProvider = FutureProvider<int>((ref) async {
  final batteryService = ref.read(batteryServiceProvider);
  return batteryService.getBatteryLevel();
});

/// Fetches battery state asynchronously
final batteryStateProvider = FutureProvider((ref) async {
  final batteryService = ref.read(batteryServiceProvider);
  return batteryService.getBatteryState();
});