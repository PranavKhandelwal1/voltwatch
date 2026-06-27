import 'package:flutter/material.dart';
import '../../data/models/battery_log_model.dart';

/// Single battery log item widget
class LogTile extends StatelessWidget {
  final BatteryLog log;

  const LogTile({
    super.key,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text("${log.batteryLevel}%"),
        ),

        title: Text(
          log.batteryState.toUpperCase(),
        ),

        subtitle: Text(
          log.timestamp.toString(),
        ),

        trailing: const Icon(Icons.battery_std),
      ),
    );
  }
}