// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData light = ThemeData(
  fontFamily: GoogleFonts.play().fontFamily,
  textTheme: GoogleFonts.playTextTheme().copyWith(
    displayLarge: TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Color(0xFF2D2D2D),
    ),
    displayMedium: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Color(0xFF2D2D2D),
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2D2D2D),
    ),
    headlineMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFF2D2D2D),
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2D2D2D),
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFF2D2D2D),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Color(0xFF2D2D2D),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFF2D2D2D),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFF2D2D2D),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFF2D2D2D),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Color(0xFF2D2D2D),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Color(0xFF2D2D2D),
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Color(0xFF2D2D2D),
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF394170),
    secondary: Color(0xFF0D2B17),
    surface: Color(0xFFF5F7F8),
    onSurface: Color(0xFF2D2D2D),
  ),
  scaffoldBackgroundColor: Color(0xFFF5F7F8),
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
      foregroundColor: Color(0xFF394170),
      backgroundColor: Color(0xFFF5F7F8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Color(0xFFF5F7F8),
        width: 0,
      ),
    ),
    labelStyle: TextStyle(
      color: Color(0xFF2D2D2D),
    ),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.resolveWith<Color?>(
      (states) => Color(0xFFF5F7F8),
    ),
  ),
);
