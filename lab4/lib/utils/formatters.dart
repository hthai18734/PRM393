import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatters {
  // Format amount to Vietnamese currency format: e.g., 850.000 đ
  static String formatVND(double amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)} đ';
  }

  // Categories list as specified in Lab4
  static const List<String> categories = [
    'Utilities',
    'Subscription',
    'Rent',
    'Finance',
    'Health',
  ];

  // Category Icon helper
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'utilities':
        return Icons.lightbulb_outline;
      case 'subscription':
        return Icons.subscriptions_outlined;
      case 'rent':
        return Icons.home_outlined;
      case 'finance':
        return Icons.account_balance_wallet_outlined;
      case 'health':
        return Icons.favorite_outline;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  // Category Color helper
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'utilities':
        return const Color(0xFFF57C00); // Amber / Orange
      case 'subscription':
        return const Color(0xFF7E57C2); // Purple
      case 'rent':
        return const Color(0xFF1E88E5); // Blue
      case 'finance':
        return const Color(0xFF43A047); // Green
      case 'health':
        return const Color(0xFFE53935); // Red
      default:
        return const Color(0xFF546E7A); // Blue Grey
    }
  }
}
