import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/storage_service.dart';
import 'presentation/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  runApp(
    const ProviderScope(
      child: VoltWatchApp(),
    ),
  );
}

class VoltWatchApp extends StatelessWidget {
  const VoltWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoltWatch',
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}