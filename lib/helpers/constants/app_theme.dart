import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
class AppThemes {
  static ThemeData main({
    bool isDark = false,
    Color primaryColor = AppColors.primaryBackground,
  }) {
    return ThemeData(
      fontFamily: 'Quicksand',
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor:
      isDark ? AppColors.black : AppColors.backgroundGrey,
      cardColor: isDark ? AppColors.blackLight : AppColors.white,
      dividerColor: isDark
          ? AppColors.white.withOpacity(0.2)
          : AppColors.black.withOpacity(0.1),
      shadowColor: isDark ? AppColors.text : AppColors.grayDark,
      primarySwatch: AppColors.getMaterialColorFromColor(primaryColor),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.backgroundGrey,
        systemOverlayStyle:
        isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        headlineSmall: TextStyle(
          color: Color(0xFF1C1D3E),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
        headlineMedium: TextStyle(
          color: Color(0xFF1C1D3E),
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ),
        displaySmall: TextStyle(
          color: Color(0xdd000000),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        displayMedium: TextStyle(
          color: Color(0xdd000000),
          fontSize: 60,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        displayLarge: TextStyle(
          color: Color(0xdd000000),
          fontSize: 96,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        bodyMedium: TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        bodyLarge: TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        bodySmall: TextStyle(
          color: Color(0x8a000000),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        labelLarge: TextStyle(
          color: Color(0xdd000000),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        titleMedium: TextStyle(
          color: Color(0xff000000),
          fontSize: 17,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
        titleSmall: TextStyle(
          color: Color(0xff000000),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
        labelSmall: TextStyle(
          color: Color(0xff000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
