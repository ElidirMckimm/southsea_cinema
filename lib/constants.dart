import 'package:flutter/material.dart';

const String appTitle = 'Southsea Cinema';

const Color cinemaBrand = Color(0xFF55BEDE);
const Color cinemaBrandLight = Color(0xFF7FCEE6);
const Color cinemaBrandDark = Color(0xFF3FB5D9);

const Color cinemaBackground = Color(0xFF1B1E28);
const Color cinemaFontWhite = Color(0xFFFFFFFF);
const Color cinemaFontMuted = Color(0xFF8A90A0);
const Color cinemaSurface = Color(0xFF242936);
const Color cinemaLightBrand = Color(0xFF006B85);
const Color cinemaLightBackground = Color(0xFFF4F6F8);
const Color cinemaLightSurface = Color(0xFFFFFFFF);
const Color cinemaLightText = Color(0xFF1B1E28);
const Color cinemaLightMuted = Color(0xFF59616E);

const String cinemaLightModePreferenceKey = 'cinema_light_mode';

ThemeData cinemaTheme(Brightness brightness) {
  final bool isDark = brightness == Brightness.dark;
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: isDark ? cinemaBrand : cinemaLightBrand,
    brightness: brightness,
  ).copyWith(
    primary: isDark ? cinemaBrand : cinemaLightBrand,
    onPrimary: cinemaFontWhite,
    surface: isDark ? cinemaSurface : cinemaLightSurface,
    onSurface: isDark ? cinemaFontWhite : cinemaLightText,
    onSurfaceVariant: isDark ? cinemaFontMuted : cinemaLightMuted,
  );
  final ThemeData baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: isDark ? cinemaBackground : cinemaLightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      iconTheme: IconThemeData(color: colorScheme.primary),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
