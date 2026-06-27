import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Handles local notifications
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification settings
  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings: settings);

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// Show battery threshold notification
  static Future<void> showBatteryAlert(int level) async {
    const androidDetails = AndroidNotificationDetails(
      'battery_alert_channel',
      'Battery Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id: 0,
      title: 'Battery Alert',
      body: 'Battery is at $level%',
      notificationDetails: notificationDetails,
    );
  }
}
