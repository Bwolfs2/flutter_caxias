import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _surfaceDeep = Color(0xFF0B0E14);
const Color _surfaceCard = Color(0xFF161B22);
const Color _accentBlue = Color(0xFF4A90E2);
const Color _accentBlueLight = Color(0xFF7EB6FF);

ThemeData buildAppTheme() {
  final ColorScheme colorScheme = ColorScheme.dark(
    surface: _surfaceDeep,
    onSurface: const Color(0xFFE6EDF3),
    primary: _accentBlue,
    onPrimary: Colors.white,
    secondary: _accentBlueLight,
    onSecondary: const Color(0xFF0B0E14),
    surfaceContainerHighest: _surfaceCard,
    onSurfaceVariant: const Color(0xFF9BA3AF),
    outline: const Color(0xFF30363D),
  );
  final TextTheme textTheme = GoogleFonts.interTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1),
      headlineMedium: TextStyle(fontWeight: FontWeight.w800),
      headlineSmall: TextStyle(fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(height: 1.55),
      bodyMedium: TextStyle(height: 1.5),
    ),
  ).apply(
    bodyColor: colorScheme.onSurface,
    displayColor: colorScheme.onSurface,
  );
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: _surfaceDeep,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: _surfaceDeep.withValues(alpha: 0.92),
      foregroundColor: colorScheme.onSurface,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: _surfaceCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.9)),
        foregroundColor: colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    ),
  );
}

LinearGradient brandTitleGradient() {
  return const LinearGradient(
    colors: <Color>[
      _accentBlue,
      _accentBlueLight,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

LinearGradient primaryCtaGradient() {
  return const LinearGradient(
    colors: <Color>[
      Color(0xFF3D7DD9),
      _accentBlueLight,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// CTA on event listing cards (light blue → deeper blue, dark label).
LinearGradient eventListingCtaGradient() {
  return const LinearGradient(
    colors: <Color>[
      Color(0xFF90CAF9),
      Color(0xFF1976D2),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
