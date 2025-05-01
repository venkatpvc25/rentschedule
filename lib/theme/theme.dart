import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6A5AE0), // Main Purple (matching buttons/icons)
      onPrimary: Colors.white, // Text/Icon color on primary
      secondary: Color(0xFFE9E6FF), // Light purple background for cards
      onSecondary: Colors.black, // Text on secondary
      error: Colors.red,
      onError: Colors.white,
      background: Color(0xFFF9F9F9), // Overall page background
      onBackground: Colors.black,
      surface: Colors.white, // Cards, containers
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF6A5AE0),
      unselectedItemColor: Colors.black54,
    ),
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6A5AE0),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  // Dark Theme (optional: if you want similar structure)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF6A5AE0),
      onPrimary: Colors.black,
      secondary: Color(0xFF1F1B41),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.black,
      background: Color(0xFF121212),
      onBackground: Colors.white,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white70,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFF6A5AE0),
      unselectedItemColor: Colors.white70,
    ),
    cardColor: const Color(0xFF1E1E1E),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6A5AE0),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Color(0xFF6A5AE0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Color(0xFF6A5AE0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Color(0xFF6A5AE0), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        labelStyle: TextStyle(color: Color(0xFF6A5AE0)),
        hintStyle: TextStyle(color: Colors.grey),
        errorStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      );

  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF6A5AE0),
    ),
  );
}
