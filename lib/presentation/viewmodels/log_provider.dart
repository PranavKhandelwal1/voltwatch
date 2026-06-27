import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/battery_log_model.dart';
import '../../data/repositories/battery_repository.dart';

/// Repository provider
final batteryRepositoryProvider = Provider((ref) {
  return BatteryRepository();
});

/// Fetch all battery logs
final batteryLogsProvider = StateProvider<List<BatteryLog>>((ref) {
  return ref.read(batteryRepositoryProvider).getLogs();
});