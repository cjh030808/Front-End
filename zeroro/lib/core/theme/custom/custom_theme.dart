import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'custom_font_weight.dart';

class CustomTheme {
  /// Typography
  static final textTheme = TextTheme(
    displayLarge: TextStyle(
      color: AppColors.black,
      fontSize: 57,
      fontWeight: CustomFontWeight.regular,
      height: 68 / 57,
    ),
    displayMedium: TextStyle(
      color: AppColors.black,
      fontSize: 45,
      fontWeight: CustomFontWeight.regular,
      height: 54 / 45,
    ),
    displaySmall: TextStyle(
      color: AppColors.black,
      fontSize: 36,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: -0.35,
      height: 45 / 36,
    ),
    headlineLarge: TextStyle(
      color: AppColors.black,
      fontSize: 32,
      fontWeight: CustomFontWeight.semiBold,
      height: 40 / 32,
    ),
    headlineMedium: TextStyle(
      color: AppColors.black,
      fontSize: 22,
      fontWeight: CustomFontWeight.semiBold,
      height: 28 / 22,
    ),
    headlineSmall: TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: -0.35,
      height: 25 / 20,
    ),
    titleLarge: TextStyle(
      color: AppColors.black,
      fontSize: 18,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: -0.35,
      height: 23 / 18,
    ),
    titleMedium: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.1,
      height: 20 / 16,
    ),
    titleSmall: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.12,
      height: 18 / 14,
    ),
    bodyLarge: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.5,
      height: 24 / 16,
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.25,
      height: 21 / 14,
    ),
    bodySmall: TextStyle(
      color: AppColors.black,
      fontSize: 12,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.4,
      height: 18 / 12,
    ),
    labelLarge: TextStyle(
      color: AppColors.black,
      fontSize: 13,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.5,
      height: 16 / 13,
    ),
    labelMedium: TextStyle(
      color: AppColors.black,
      fontSize: 12,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.25,
      height: 15 / 12,
    ),
    labelSmall: TextStyle(
      color: AppColors.black,
      fontSize: 11,
      fontWeight: CustomFontWeight.regular,
      height: 15 / 11,
    ),
  );

  /// color_scheme
  static final colorScheme = ColorScheme(
    brightness: Brightness.light, // 캐릭터랑 안맞을 수도 있어서 다크 테마 안할 듯
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    surface: AppColors.white,
    onSurface: AppColors.black,
    primaryContainer: AppColors.primaryContainer,
  );
}

// extension ColorSchemeEx on ColorScheme {
// }