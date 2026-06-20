import 'package:flutter/material.dart';

/// Sabit marka renkleri (her iki temada aynı kalır) + temaya duyarlı yardımcı.
class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color chipBg = Color(0xFFDBEAFE);
  static const Color textMuted = Color(0xFF64748B); // her iki temada okunur

  // Aşağıdakiler eski kodla uyum için duruyor (login ekranı kullanıyor).
  static const Color background = Color(0xFFF1F5F9);
  static const Color card = Colors.white;
  static const Color textDark = Color(0xFF1E293B);
  static const Color border = Color(0xFFE2E8F0);

  /// Kart yüzeyi rengi - temaya göre değişir (karanlık modda koyu).
  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1E293B)
          : Colors.white;
}
