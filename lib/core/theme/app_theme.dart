import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const primaryTextColor = Color(0xFF111111);
    const secondaryTextColor = Color(0xFF5F5F5F);
    const surfaceColor = Colors.white;
    const borderColor = Color(0xFFE0E0E0);

    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: surfaceColor,
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Color(0xFFE60023),
        surface: surfaceColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: primaryTextColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: secondaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      dividerColor: borderColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      cardColor: Colors.white,
    );
  }
}
