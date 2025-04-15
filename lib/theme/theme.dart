import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    useMaterial3: true, // Enable Material 3 design
    inputDecorationTheme: _inputDecorationTheme, // Apply form field theme
    textTheme: textTheme, // Apply text theme
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true, // Enable Material 3 design
    inputDecorationTheme: _inputDecorationTheme, // Apply form field theme
    textTheme: textTheme, // Apply text theme
  );

  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        labelStyle: TextStyle(color: Colors.deepPurple),
        hintStyle: TextStyle(color: Colors.grey),
        errorStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      );

  // Common TextTheme for light and dark themes
  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    headlineMedium: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
  );
}
