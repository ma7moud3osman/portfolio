import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightPrimaryColor = Color(0xFFFFFFFF);
  static const Color lightAccentColor = Color(0xFFB1AAAA);
  static const Color lightParticlesColor = Color(0x44948282);

  static const Color darkBackgroundColor = Color(0xFF2B2B30);
  static const Color darkPrimaryColor = Color(0xFF2B2B30);
  static const Color darkAccentColor = Color(0xFF616060);
  static const Color darkParticlesColor = Color(0x441c2a3d);

  static final lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    backgroundColor: lightBackgroundColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomAppBarColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAccentColor),
  );

  static final darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    backgroundColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkAccentColor),
  );

  static setStatusBarAndNotificationBarColor(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  static Brightness get currentSystemBrightness {
    return SchedulerBinding.instance!.window.platformBrightness;
  }
}
