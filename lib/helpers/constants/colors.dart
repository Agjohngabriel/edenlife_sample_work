import 'package:flutter/material.dart';

class AppColors {
  static const primaryBackground = Color(0xFFfdfcfb);
  static const primaryOption1 = Color(0xFF343673);
  static const Color green = Color(0xFF4CD964);
  static const white = Color(0xFFFFFFFF);
  static const offWhite = Color(0xFFF5F5F5);
  static const Color grayDark = Color.fromARGB(255, 182, 182, 182);
  static const Color grayDarker = Color(0xff38383B);
  static const Color grayLight = Color.fromARGB(255, 239, 239, 239);
  static const Color backgroundGrey = Color(0xffF0F0F0);
  static const Color gray = Color(0xffD9D9D9);
  static const Color text = Color(0xff000000);
  static const Color text50 = Color(0x88000000);
  static const Color text60 = Color(0xff0D0906);
  static const Color textgrey = Color(0xffA9ACBA);
  static const Color black = Color(0xff001424);
  static const Color black50 = Color(0x88001424);
  static const Color blackLight = Color(0xff011f35);
  static const kWhite = Color(0xffFFFFFF);
  static const kBlack = Color(0xff000000);
  static const red = Color(0xffEB5757);
  static const yellow = Color(0xffFAB513);
  static const darkblue = Color(0xff3554a8);

  static List<Color> primaryColorOptions = const [
    primaryBackground,
  ];
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
