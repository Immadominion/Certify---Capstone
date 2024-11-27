import 'package:flutter/material.dart';

/// Color Guide Notice (Primary ORANGE, INFO COLOR)
/// Ranging from (50-900)
/// 50 = Light, 100 = Light :hover, 200 = Light :active,
/// 300 = Normal, 400 = Normal :hover, 500 = Normal :active,
/// 600 = Dark, 700 = Dark :hover, 800 = Dark :active, 800 = Darker

/// Color Guide Notice (GREYS)
/// Ranging from (50-900)
/// 50 = Normal, 100 = Normal :hover, 200 = Normal :active,
/// 300 = Dark, 400 = Dark :hover, 500 = Dark :active,
/// 600 = Darker, 700 = Dark :hover, 800 = Dark :active, 800 = Darker

class CertifyColors {
  // static final ProviderContainer container = ProviderContainer();

  // static bool get isDarkTheme =>
  //     container.read(themeControllerProvider.notifier).isDarkTheme;

  // static void dispose() {
  //   container.dispose();
  // }

  static Color appBackgroundColor = const Color.fromARGB(255, 239, 239, 239);
  static List<Color> containerGradient = const [
    Color.fromARGB(100, 255, 153, 0),
    Color.fromARGB(120, 255, 172, 64),
    Color.fromARGB(140, 255, 172, 64),
    Color.fromARGB(120, 244, 67, 54),
    //add more colors for gradient
  ];
  static Color darkBackgroundColor = const Color.fromRGBO(51, 51, 51, 1);
  static Color lightBackgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color dashboardWhiteColor = const Color.fromRGBO(255, 255, 255, 0.1);
  static Color whitePaddingColor = const Color.fromRGBO(240, 240, 240, 1);
  static Color darkPaddingColor = const Color.fromRGBO(130, 70, 243, 0.5);

  static Color darkColor = const Color.fromARGB(255, 0, 0, 0);
  static Color mildLightColor = const Color.fromARGB(255, 214, 214, 214);
  static Color successColor = const Color.fromARGB(255, 24, 189, 38);
  static Color primary = const Color.fromRGBO(187, 134, 252, 1);
  static Color primaryDark = const Color.fromRGBO(130, 70, 243, 1);

  static const MaterialColor errorColor = MaterialColor(
    _errorColorValue,
    <int, Color>{
      50: Color(0xFFFDEEEE),
      100: Color(0xFFFCE6E6),
      200: Color(0xFFF9CBCB),
      300: Color(_errorColorValue),
      400: Color(0xFFD44E4E),
      500: Color(0xFFBC4646),
      600: Color(0xFFB04141),
      700: Color(0xFF8D3434),
      800: Color(0xFF6A2727),
      900: Color(0xFF521E1E),
    },
  );

  static const Color lightColor = Color(0xffffffff);
  static const Color mildGrey = Color.fromARGB(255, 51, 50, 50);
  static const MaterialColor primaryColor =
      MaterialColor(_primaryColorValue, <int, Color>{
    50: Color(0xFFFFF3E0),
    100: Color(0xFFFFE0B2),
    200: Color(0xFFFFCC80),
    300: Color(0xFFFFB74D),
    400: Color(0xFFFFA726),
    500: Color(0x000ffeee), // Your custom color: rgb(254, 85, 46)
    600: Color(0xFFFB8C00),
    700: Color(0xFFF57C00),
    800: Color(0xFFEF6C00),
    900: Color(0xFFE65100),
  });

  static Color secondaryTextColor = const Color(0xff53505b);

  static const int _errorColorValue = 0xFFB42318;
  static const int _primaryColorValue = 0xFFfa7f41;

  // static Color getAppbarBgColor() { #fa7f41
  //   return isDarkTheme
  //       ? InstaColors.darkBackgroundColor
  //       : InstaColors.appBackgroundColor;
  // }

  // static Color getTextColor() {
  //   return isDarkTheme ? InstaColors.darkColor : InstaColors.lightColor;
  // }

  // static Color getContainerColor() {
  //   return isDarkTheme ? InstaColors.mildGrey : InstaColors.lightColor;
  // }
}
