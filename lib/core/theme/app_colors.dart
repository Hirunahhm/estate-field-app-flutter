import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand color (Mapped directly to 'brand-500')
  // The vibrant Madukotewatta green used for buttons and active markers.
  static const Color primary = Color(0xFF22C55E);

  // Main app background (Mapped to CSS '--background' in Dark Mode)
  // This is a very deep slate/charcoal (#020817), matching the main web dashboard background.
  static const Color background = Color(0xFF020817);

  // Standard card/surface background (Mapped to CSS '--card' in Dark Mode)
  // Matching the web dashboard cards, this is slightly elevated slate.
  static const Color surface = Color(0xFF0F172A);

  // Inset or lower-elevation surfaces (A darker shade of slate)
  // Used for inputs or depressed areas.
  static const Color surfaceDark = Color(0xFF020817);

  // Borders and dividers (Mapped to CSS '--border' in Dark Mode)
  // A clean, visible-but-subtle line (#1E293B) connecting layout elements.
  static const Color surfaceBorder = Color(0xFF1E293B);

  // Hover or slight emphasis states (Mapped to CSS '--secondary' in Dark Mode)
  static const Color surfaceHighlight = Color(0xFF1E293B);

  // Pressed or heavily active states (Mapped to CSS '--muted' hover)
  static const Color surfaceActive = Color(0xFF334155);

  // Destructive actions/errors (Mapped to CSS '--destructive')
  // The exact red hue used for errors on the web interface.
  static const Color actionRed = Color(0xFF7F1D1D);

  // Secondary text and icons (Mapped to CSS '--muted-foreground')
  // Highly legible slate-gray text (#94A3B8).
  static const Color textMuted = Color(0xFF94A3B8);
}
