import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E), // High Contrast Dark Grey
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00E5FF), // Vibrant Cyan
      secondary: Color(0xFF00E5FF), // Matching Accent
      surface: Color(0xFF2D2D2D), // Lighter Grey
      onSurface: Color(0xFFEDEDED), // Almost White
      error: Color(0xFFEF4444),
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: const Color(0xFFEDEDED),
      displayColor: const Color(0xFFEDEDED),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2D2D2D),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFFEDEDED).withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF383838), // Slightly lighter than surface
      labelStyle: const TextStyle(color: Color(0xFFAAAAAA)), // Light Grey
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: const Color(0xFFEDEDED).withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: const Color(0xFFEDEDED).withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 2),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFEDEDED),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF1E1E1E), // Match scaffoldBackgroundColor
      surfaceTintColor: Colors.transparent, // Disable tint
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      headerBackgroundColor: const Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
      headerForegroundColor: Colors.white,
      dayStyle: const TextStyle(color: Colors.white),
      yearStyle: const TextStyle(color: Colors.white),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.black;
        return Colors.white;
      }),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.black;
        return Colors.white;
      }),
      todayForegroundColor:
          WidgetStateProperty.all(const Color(0xFF00E5FF)), // Cyan for Today
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(const Color(0xFF00E5FF)),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white70),
      ),
    ),
  );
}
