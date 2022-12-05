// Packages
import 'package:flutter/material.dart';

// Core
import '../../core/utils/app_colors.dart';

final ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    centerTitle: true,
  ),
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: AppColors.primary),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.secondary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: AppColors.primary),
    iconColor: AppColors.secondary,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
