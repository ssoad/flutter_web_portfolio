import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF2196F3);
  static const Color _lightSecondary = Color(0xFF00BCD4);
  static const Color _lightBackground = Color(0xFFF5F5F5);
  static const Color _lightSurface = Colors.white;
  static const Color _lightText = Color(0xFF1A1A1A);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF64B5F6);
  static const Color _darkSecondary = Color(0xFF4DD0E1);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkText = Color(0xFFFAFAFA);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimary,
    colorScheme: ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      background: _lightBackground,
      surface: _lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: _lightText,
      onSurface: _lightText,
    ),
    scaffoldBackgroundColor: _lightBackground,
    cardColor: _lightSurface,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: _lightText,
      displayColor: _lightText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _lightPrimary,
      ),
    ),
    cardTheme: CardTheme(
      color: _lightSurface,
      elevation: 4,
      shadowColor: _lightPrimary.withOpacity(0.2),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      background: _darkBackground,
      surface: _darkSurface,
      onPrimary: _darkText,
      onSecondary: _darkText,
      onBackground: _darkText,
      onSurface: _darkText,
    ),
    scaffoldBackgroundColor: _darkBackground,
    cardColor: _darkSurface,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: _darkText,
      displayColor: _darkText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _darkText,
        backgroundColor: _darkPrimary,
      ),
    ),
    cardTheme: CardTheme(
      color: _darkSurface,
      elevation: 4,
      shadowColor: _darkPrimary.withOpacity(0.2),
    ),
  );
}
