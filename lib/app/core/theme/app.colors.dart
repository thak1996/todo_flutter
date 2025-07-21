import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // Brand Colors
  static Color get primary => const Color(0xFF2196F3);
  static Color get secondary => const Color(0xFF64B5F6);
  static Color get accent => const Color(0xFF448AFF);

  // Feedback Colors
  static Color get success => const Color(0xFF4CAF50);
  static Color get warning => const Color(0xFFFFC107);
  static Color get error => const Color(0xFFF44336);

  // Neutral Colors
  static Color get grey100 => const Color(0xFFF5F5F5);
  static Color get grey200 => const Color(0xFFEEEEEE);
  static Color get grey300 => const Color(0xFFE0E0E0);

  // Surface Colors
  static Color get background => const Color(0xFFFFFFFF);
  static Color get surface => const Color(0xFFFFFFFF);

  // Text Colors
  static Color get textPrimary => const Color(0xFF212121);
  static Color get textSecondary => const Color(0xFF757575);
  static Color get textDisabled => const Color(0xFFBDBDBD);

  // Link Colors
  static Color get link => const Color(0xFF2196F3);
}
