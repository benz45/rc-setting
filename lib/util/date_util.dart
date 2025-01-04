import 'package:intl/intl.dart';

class ExpiryChecker {
  /// Check if date is expired compared to current date
  static bool isExpired(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(now);
  }

  /// Check if date is expired with custom comparison date
  static bool isExpiredComparedTo(DateTime date, DateTime comparisonDate) {
    return date.isBefore(comparisonDate);
  }

  /// Get days remaining until expiry (negative if expired)
  static int daysUntilExpiry(DateTime expiryDate) {
    final now = DateTime.now();
    return expiryDate.difference(now).inDays;
  }

  /// Check if date is within warning period (e.g., expires in next 7 days)
  static bool isNearExpiry(DateTime date, {int warningDays = 7}) {
    final now = DateTime.now();
    final daysRemaining = date.difference(now).inDays;
    return daysRemaining >= 0 && daysRemaining <= warningDays;
  }

  /// Get expiry status with more details
  static ExpiryStatus getExpiryStatus(DateTime date, {int warningDays = 7}) {
    final now = DateTime.now();
    final daysRemaining = date.difference(now).inDays;

    if (daysRemaining < 0) {
      return ExpiryStatus(
        isExpired: true,
        isNearExpiry: false,
        daysRemaining: daysRemaining,
        message: 'Expired ${-daysRemaining} days ago',
      );
    } else if (daysRemaining <= warningDays) {
      return ExpiryStatus(
        isExpired: false,
        isNearExpiry: true,
        daysRemaining: daysRemaining,
        message: 'Expires in $daysRemaining days',
      );
    } else {
      return ExpiryStatus(
        isExpired: false,
        isNearExpiry: false,
        daysRemaining: daysRemaining,
        message: 'Valid for $daysRemaining days',
      );
    }
  }

  /// Parse date string and check expiry
  static ExpiryStatus checkStringDate(String dateStr, String format) {
    try {
      final date = DateFormat(format).parse(dateStr);
      return getExpiryStatus(date);
    } catch (e) {
      return ExpiryStatus(
        isExpired: true,
        isNearExpiry: false,
        daysRemaining: 0,
        message: 'Invalid date format',
        error: e.toString(),
      );
    }
  }
}

/// Class to hold expiry status information
class ExpiryStatus {
  final bool isExpired;
  final bool isNearExpiry;
  final int daysRemaining;
  final String message;
  final String? error;

  ExpiryStatus({
    required this.isExpired,
    required this.isNearExpiry,
    required this.daysRemaining,
    required this.message,
    this.error,
  });
}