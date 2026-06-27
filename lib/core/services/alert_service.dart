/// Prevents repeated notifications
class AlertService {
  static bool hasNotified = false;

  /// Check if notification can be sent
  static bool canNotify(int currentLevel, int threshold) {
    if (currentLevel >= threshold && !hasNotified) {
      hasNotified = true;
      return true;
    }

    // Reset if battery drops below threshold
    if (currentLevel < threshold) {
      hasNotified = false;
    }

    return false;
  }
}