// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants/env_colors.dart';

/// You should assign the textStyle as so => 'textStyle: Theme.of(context).textStyle.textStyleNameAccordingToTheme' e.g Theme.of(context).colorScheme.bodyLarge

class EnvThemeManager {
  EnvThemeManager._();

  static String get fontFamily => 'Int';
  static ThemeData lightTheme = themeData(_lightColorScheme);
  static ThemeData darkTheme = themeData(_darkColorScheme);

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: CertifyColors.primary,
    error: const Color.fromARGB(255, 209, 35, 23),
    background: CertifyColors.appBackgroundColor,
    inverseSurface: CertifyColors.darkBackgroundColor,
    surface: CertifyColors.lightBackgroundColor,
    onBackground: CertifyColors.darkColor,
    onPrimary: CertifyColors.darkColor,
    shadow: CertifyColors.darkColor,
    onPrimaryContainer: CertifyColors.darkColor,
    onInverseSurface: CertifyColors.dashboardWhiteColor,
    onSecondary: CertifyColors.darkColor,
    onSurface: CertifyColors.darkColor,
    onSurfaceVariant: CertifyColors.whitePaddingColor,
    onTertiary: CertifyColors.darkColor.withOpacity(0.5),
    onErrorContainer: CertifyColors.lightColor,
    onTertiaryContainer: CertifyColors.darkBackgroundColor,
    onSecondaryContainer: CertifyColors.whitePaddingColor,
    brightness: Brightness.light,
    errorContainer: CertifyColors.errorColor,
    inversePrimary: CertifyColors.primary,
    outline: CertifyColors.darkColor,
    outlineVariant: CertifyColors.lightColor,
    onError: CertifyColors.darkColor,
    primaryContainer: CertifyColors.lightBackgroundColor,
    secondary: CertifyColors.mildLightColor,
    scrim: CertifyColors.darkBackgroundColor,
    surfaceTint: CertifyColors.mildLightColor,
  );
  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: CertifyColors.primary,
    error: CertifyColors.errorColor,
    background: CertifyColors.darkBackgroundColor,
    surface: CertifyColors.darkBackgroundColor,
    onBackground: CertifyColors.lightColor,
    onPrimary: CertifyColors.lightColor,
    shadow: CertifyColors.lightColor,
    onSurface: CertifyColors.lightColor,
    onError: CertifyColors.lightColor,
    onSecondary: CertifyColors.lightColor,
    onInverseSurface: CertifyColors.darkBackgroundColor.withOpacity(.5),
    onPrimaryContainer: CertifyColors.lightColor,
    brightness: Brightness.dark,
    errorContainer: CertifyColors.errorColor,
    onSecondaryContainer: CertifyColors.darkPaddingColor,
    onSurfaceVariant: CertifyColors.lightColor,
    onTertiary: CertifyColors.lightColor,
    onTertiaryContainer: CertifyColors.lightColor,
    primaryContainer: CertifyColors.darkColor,
    secondary: CertifyColors.mildGrey,
    secondaryContainer: CertifyColors.darkColor,
    surfaceVariant: CertifyColors.darkColor,
    surfaceTint: CertifyColors.mildLightColor,
    scrim: CertifyColors.primary,
    tertiary: CertifyColors.mildGrey,
    tertiaryContainer: CertifyColors.darkColor,
    inversePrimary: CertifyColors.darkBackgroundColor,
  );

  static ThemeData themeData(ColorScheme colorScheme) => ThemeData(
      //   canvasColor: colorScheme.onSurface,
      scaffoldBackgroundColor: colorScheme.background,
      useMaterial3: false,
      colorScheme: colorScheme,
      iconTheme: _iconTheme(colorScheme),
      fontFamily: "Int",
      appBarTheme: _appBarTheme(colorScheme),
      disabledColor: colorScheme.inverseSurface,
      brightness: colorScheme.brightness,
      primaryColor: CertifyColors.primaryColor,
      tooltipTheme: TooltipThemeData(
        height: 1000,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: CertifyColors.primaryColor,
        cursorColor: CertifyColors.primaryColor,
        selectionHandleColor: Colors.blue,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.background,
      ));

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: _iconTheme(colorScheme),
        actionsIconTheme: _iconTheme(colorScheme),
      );

  static IconThemeData _iconTheme(ColorScheme colorScheme) => IconThemeData(
        color: colorScheme.onSurface,
      );
}
