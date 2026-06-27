import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/battery_service.dart';

/// Provides BatteryService globally
final batteryServiceProvider = Provider((ref) {
  return BatteryService();
});

/// Real-time battery level provider
final batteryLevelStreamProvider = StreamProvider<int>((ref) async* {
  final batteryService = ref.read(batteryServiceProvider);

  while (true) {
    // Fetch battery percentage every 5 seconds
    final level = await batteryService.getBatteryLevel();

    yield level;

    await Future.delayed(const Duration(seconds: 5));
  }
});

/// Real-time battery state provider
final batteryStateStreamProvider = StreamProvider<BatteryState>((ref) {
  final batteryService = ref.read(batteryServiceProvider);

  return batteryService.batteryStateStream();
});