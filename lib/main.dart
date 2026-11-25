import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  runApp(const SouthseaCinemaApp());
}

class SouthseaCinemaApp extends StatefulWidget {
  const SouthseaCinemaApp({super.key});

  @override
  State<SouthseaCinemaApp> createState() => _SouthseaCinemaAppState();
}

class _SouthseaCinemaAppState extends State<SouthseaCinemaApp> {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final bool? isLightMode =
        await _preferences.getBool(cinemaLightModePreferenceKey);
    if (!mounted || isLightMode == null) {
      return;
    }

    setState(() {
      _themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  Future<void> _setLightMode(bool isLightMode) async {
    final ThemeMode previousThemeMode = _themeMode;
    setState(() {
      _themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    });

    try {
      await _preferences.setBool(cinemaLightModePreferenceKey, isLightMode);
    } catch (error) {
      if (mounted) {
        setState(() {
          _themeMode = previousThemeMode;
        });
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: cinemaTheme(Brightness.light),
      darkTheme: cinemaTheme(Brightness.dark),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/basket': (context) => const BasketView(),
        '/settings': (context) =>
            SettingsView(onLightModeChanged: _setLightMode),
        //'/listing': (context) => const MovieListingView(),
      },
    );
  }
}
