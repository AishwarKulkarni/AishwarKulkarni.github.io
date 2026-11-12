import 'package:flutter/material.dart';

/// Design tokens and color system for the portfolio.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bg = Color(0xFF040711);
  static const Color surface = Color(0xFF090E1D);
  static const Color panel = Color(0xFF0E1528);
  static const Color panelElevated = Color(0xFF141F3A);

  // Borders & Dividers
  static const Color border = Color(0xFF1C2A4A);
  static const Color borderSubtle = Color(0xFF131D33);
  static const Color borderBright = Color(0xFF2E477D);

  // Typography
  static const Color text = Color(0xFFF1F5FB);
  static const Color textSecondary = Color(0xFFCAD5E8);
  static const Color dim = Color(0xFF8294B5);
  static const Color dimmer = Color(0xFF4C5D7E);

  // Accents
  static const Color blue = Color(0xFF387BFF);
  static const Color cyan = Color(0xFF00D2FF);
  static const Color green = Color(0xFF10B981);
  static const Color red = Color(0xFFF43F5E);
  static const Color amber = Color(0xFFF59E0B);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color visor = Color(0xFF90E0EF);

  // Ink / Outline
  static const Color ink = Color(0xFF020409);
}

/// Shorthand alias for concise styling code.
typedef P = AppColors;

