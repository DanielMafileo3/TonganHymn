import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static int lightDay = 0;
  static int darkNight = 1;
  static int dark = 2;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.lightDay: ThemeData(brightness: Brightness.light),
    AppThemes.darkNight: ThemeData(brightness: Brightness.dark),
    AppThemes.dark: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);
