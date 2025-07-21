import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app.colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: AppColors.textPrimary,
            ),
            displayMedium: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
              color: AppColors.textPrimary,
            ),
            displaySmall: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
              color: AppColors.textPrimary,
            ),
            headlineMedium: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: AppColors.textPrimary,
            ),
            headlineSmall: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: AppColors.textPrimary,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: AppColors.textPrimary,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 14,
              letterSpacing: 0.15,
              color: AppColors.textSecondary,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 12,
              letterSpacing: 0.15,
              color: AppColors.textSecondary,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
              color: AppColors.textSecondary,
            ),
          ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.fromHeight(48),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.fromHeight(48),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.fromHeight(48),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hoverColor: Colors.transparent,
        focusColor: AppColors.grey200,
        filled: true,
        fillColor: AppColors.grey100,
        labelStyle: TextStyle(color: AppColors.textPrimary),
        hintStyle: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .apply(bodyColor: Colors.white, displayColor: Colors.white)
          .copyWith(
            displayLarge: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
            displayMedium: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
              color: Colors.white,
            ),
            displaySmall: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
              color: Colors.white,
            ),
            headlineMedium: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
            headlineSmall: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 14,
              letterSpacing: 0.15,
              color: Colors.white,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 12,
              letterSpacing: 0.15,
              color: Colors.white70,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
              color: Colors.white70,
            ),
          ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.fromHeight(48),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: Colors.white,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        fillColor: Colors.grey[900],
        filled: true,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
