import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/styles/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/styles/app_colors.dart';

class AppTheme {
  final String fontFamily; // instance variable
  static const double _insetXl = 32.0;

  AppTheme({required this.fontFamily});

  // --- 1. Button State Handlers ---

  final _primaryButtonStates =
  WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.pressed)) {
      return const Color(0xff561895).withOpacity(0.7);
    }
    return AppColors.primaryColor;
  });

  final _outlineButtonStates =
  WidgetStateProperty.resolveWith<BorderSide?>((Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.pressed)) {
      return BorderSide(color: const Color(0xff561895).withOpacity(0.7));
    }
    return const BorderSide(color: Color(0xff561895));
  });

  // --- 2. Text Styles (Now instance-based, uses this.fontFamily) ---

  WidgetStatePropertyAll<TextStyle> get _darkElevatedButtonTextStyle =>
      WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          color: AppColors.gray[100],
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
        ),
      );

  WidgetStatePropertyAll<TextStyle> get _lightElevatedButtonTextStyle =>
      WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          color: AppColors.gray[100],
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
        ),
      );

  WidgetStatePropertyAll<TextStyle> get _darkOutlinedButtonTextStyle =>
      WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          color: AppColors.gray[100],
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
        ),
      );

  WidgetStatePropertyAll<TextStyle> get _lightOutlinedButtonTextStyle =>
      WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          color: AppColors.gray[800],
          fontFamily: fontFamily,
        ),
      );

  // --- 3. Base ThemeData builder (no longer static) ---

  ThemeData _getThemeData({
    required ColorScheme colorScheme,
    required WidgetStateProperty<TextStyle> elevatedButtonTextStyle,
    required WidgetStateProperty<TextStyle> outlinedButtonTextStyle,
    required Color scaffoldBackgroundColor,
    required AppBarTheme appBarTheme,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: appBarTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
          backgroundColor: _primaryButtonStates,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: _insetXl, vertical: 10),
          ),
          textStyle: elevatedButtonTextStyle,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          fixedSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
          side: _outlineButtonStates,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: _insetXl, vertical: 10),
          ),
          textStyle: outlinedButtonTextStyle,
        ),
      ),
    );
  }

  // --- 4. Public Theme Getters (instance-based) ---

  ThemeData get light => _getThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      background: AppColors.gray[100]!,
      surface: AppColors.gray[200]!,
      outline: AppColors.gray[300]!,
      outlineVariant: AppColors.gray[400]!,
      onBackground: AppColors.gray[800]!,
      onSurface: AppColors.gray[700]!,
      onSurfaceVariant: AppColors.gray[600]!,
      tertiary: AppColors.gray[900]!,
    ),
    elevatedButtonTextStyle: _lightElevatedButtonTextStyle,
    outlinedButtonTextStyle: _lightOutlinedButtonTextStyle,
    scaffoldBackgroundColor: AppColors.gray[100]!,
    appBarTheme: AppBarTheme(color: AppColors.gray[100]!.withOpacity(0.3)),
  );

  ThemeData get dark => _getThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      background: AppColors.darkBackgroundColor,
      surface: AppColors.gray[850]!,
      outline: AppColors.gray[800]!,
      outlineVariant: AppColors.gray[700]!,
      onBackground: AppColors.gray[100]!,
      onSurface: AppColors.gray[300]!,
      onSurfaceVariant: AppColors.gray[400]!,
      tertiary: AppColors.gray[900]!,
    ),
    elevatedButtonTextStyle: _darkElevatedButtonTextStyle,
    outlinedButtonTextStyle: _darkOutlinedButtonTextStyle,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    appBarTheme: AppBarTheme(color: AppColors.gray[900]!.withOpacity(0.3)),
  );
}
