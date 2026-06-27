import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

/// Stores custom battery threshold
final batteryThresholdProvider = StateProvider<int>((ref) {
  final settingsBox = Hive.box('settings');

  return settingsBox.get('threshold', defaultValue: 80);
});