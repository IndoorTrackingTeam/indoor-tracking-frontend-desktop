// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData dark = ThemeData(
  fontFamily: GoogleFonts.play().fontFamily,
  textTheme: GoogleFonts.playTextTheme().copyWith(
    displayLarge: TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Color(0xFFF5F7F8),
    ),
    displayMedium: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Color(0xFFF5F7F8),
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F7F8),
    ),
    headlineMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFFF5F7F8),
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F7F8),
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFFF5F7F8),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Color(0xFFF5F7F8),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFFF5F7F8),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFFF5F7F8),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFFF5F7F8),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Color(0xFFF5F7F8),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Color(0xFFF5F7F8),
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Color(0xFFF5F7F8),
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF394170),
    secondary: Color(0xFF0D2B17),
    surface: Color(0xFFF5F7F8),
    onSurface: Color(0xFFF5F7F8),
  ),
  scaffoldBackgroundColor: Color(0xFF1E1E1E),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF394170),
    titleTextStyle: GoogleFonts.play(
      color: Color(0xFFF5F7F8),
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Color(0xFFF5F7F8),
      backgroundColor: Color(0xFF394170),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFF5F7F8),
      backgroundColor: Color(0xFF394170),
      side: BorderSide(color: Color(0xFFF5F7F8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFF5F7F8),
      backgroundColor: Color(0xFF394170),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF394170);
        }
        return Color(0xFFF5F7F8);
      },
    ),
    trackColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return Color(0xFFBDBDBD);
      },
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Color(0xFF2D2D2D),
        width: 0,
      ),
    ),
    labelStyle: TextStyle(
      color: Color(0xFFF5F7F8),
    ),
    filled: true,
    fillColor: Color(0xFF2D2D2D),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateColor.resolveWith(
      (states) => Color(0xFF2D2D2D),
    ),
    checkColor: MaterialStateProperty.resolveWith<Color?>(
      (states) => Color(0xFFF5F7F8),
    ),
    side: BorderSide(
      color: Color(0xFFF5F7F8),
    ),
  ),
);
