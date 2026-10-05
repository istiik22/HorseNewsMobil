import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// цвета собраны в одном месте, чтобы потом легко было переключить на светлую тему
// пофиксить: сейчас светлая тема не реализована, только тёмная
class AppColors {
  static const bg = Color(0xFF14100D);
  static const surface = Color(0xFF1F1913);
  static const surfaceAlt = Color(0xFF2A2118);
  static const gold = Color(0xFFC9A24B);
  static const goldSoft = Color(0xFFE3C77E);
  static const text = Color(0xFFF2EADC);
  static const textMuted = Color(0xFF9A8E7C);
  static const border = Color(0xFF3A2E22);
}

class AppTheme {
  static ThemeData get dark {
    // шрифт один на всё приложение, чтобы не дублировать в каждом Text
    final base = GoogleFonts.cormorantGaramondTextTheme();
    final body = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.goldSoft,
        surface: AppColors.surface,
        onSurface: AppColors.text,
      ),
      textTheme: body.copyWith(
        displayLarge: base.displayLarge?.copyWith(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: base.titleLarge?.copyWith(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: body.titleMedium?.copyWith(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        bodyMedium: body.bodyMedium?.copyWith(color: AppColors.text),
        bodySmall: body.bodySmall?.copyWith(color: AppColors.textMuted),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: base.headlineMedium?.copyWith(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}