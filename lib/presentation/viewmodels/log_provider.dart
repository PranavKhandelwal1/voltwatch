import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/battery_log_model.dart';
import '../../data/repositories/battery_repository.dart';

/// Provides BatteryRepository globally
final batteryRepositoryProvider = Provider<BatteryRepository>((ref) {
  return BatteryRepository();
});

/// Stores all battery logs in memory
final batteryLogsProvider =
StateProvider<List<BatteryLog>>((ref) {
  return ref.read(batteryRepositoryProvider).getLogs();
});