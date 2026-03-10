import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';

TextTheme _buildTextTheme() => const TextTheme(
      displayLarge:  TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 40 / 32),
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 32 / 24),
      headlineMedium:TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 28 / 20),
      titleLarge:    TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 26 / 18),
      titleMedium:   TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 24 / 16),
      bodyLarge:     TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 24 / 16),
      bodyMedium:    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 20 / 14),
      bodySmall:     TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 16 / 12),
      labelLarge:    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 20 / 14),
      labelMedium:   TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 16 / 12),
      labelSmall:    TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 14 / 11),
    );

ThemeData buildDarkTheme() {
  const colorScheme = ColorScheme.dark(
    brightness:       Brightness.dark,
    surface:          AppColors.darkSurface,
    surfaceContainerHighest: AppColors.darkSurfaceVariant,
    primary:          AppColors.darkPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    secondary:        AppColors.darkSecondary,
    error:            AppColors.darkError,
    onPrimary:        Colors.white,
    onSurface:        AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
  );

  return ThemeData(
    useMaterial3:  true,
    colorScheme:   colorScheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme:     _buildTextTheme().apply(
      bodyColor:    AppColors.darkTextPrimary,
      displayColor: AppColors.darkTextPrimary,
    ),
    dividerColor:  AppColors.darkDivider,
    cardTheme: CardThemeData(
      color:     AppColors.darkSurface,
      elevation: 0,
      shape:     RoundedRectangleBorder(borderRadius: AppRadius.lgBorder),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled:          true,
      fillColor:       AppColors.darkSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.darkDivider, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.darkDivider, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.darkPrimary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.darkError, width: 1.5),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize:      const Size.fromHeight(48),
        padding:          const EdgeInsets.symmetric(horizontal: 24),
        shape:            RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
        backgroundColor:  AppColors.darkPrimary,
        foregroundColor:  Colors.white,
        disabledBackgroundColor: AppColors.darkPrimary.withValues(alpha: 0.38),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        padding:     const EdgeInsets.symmetric(horizontal: 24),
        shape:       RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
        side:        const BorderSide(color: AppColors.darkPrimary, width: 1.5),
        foregroundColor: AppColors.darkPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:      AppColors.darkSurface,
      selectedItemColor:    AppColors.darkPrimary,
      unselectedItemColor:  AppColors.darkTextSecondary,
      showUnselectedLabels: false,
      type:                 BottomNavigationBarType.fixed,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor:      AppColors.darkSurface,
      indicatorColor:       AppColors.darkPrimaryContainer,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.darkPrimary);
        }
        return const IconThemeData(color: AppColors.darkTextSecondary);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: AppColors.darkPrimary, fontSize: 12);
        }
        return const TextStyle(color: AppColors.darkTextSecondary, fontSize: 12);
      }),
    ),
  );
}

ThemeData buildLightTheme() {
  const colorScheme = ColorScheme.light(
    brightness:       Brightness.light,
    surface:          AppColors.lightSurface,
    surfaceContainerHighest: AppColors.lightSurfaceVariant,
    primary:          AppColors.lightPrimary,
    primaryContainer: AppColors.lightPrimaryContainer,
    secondary:        AppColors.lightSecondary,
    error:            AppColors.lightError,
    onPrimary:        Colors.white,
    onSurface:        AppColors.lightTextPrimary,
    onSurfaceVariant: AppColors.lightTextSecondary,
  );

  return ThemeData(
    useMaterial3:  true,
    colorScheme:   colorScheme,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme:     _buildTextTheme().apply(
      bodyColor:    AppColors.lightTextPrimary,
      displayColor: AppColors.lightTextPrimary,
    ),
    dividerColor:  AppColors.lightDivider,
    cardTheme: CardThemeData(
      color:     AppColors.lightSurface,
      elevation: 0,
      shape:     RoundedRectangleBorder(borderRadius: AppRadius.lgBorder),
      shadowColor: Colors.black.withValues(alpha: 0.08),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled:    true,
      fillColor: AppColors.lightSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.lightDivider, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.lightDivider, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.lightPrimary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.smBorder,
        borderSide:   const BorderSide(color: AppColors.lightError, width: 1.5),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize:      const Size.fromHeight(48),
        padding:          const EdgeInsets.symmetric(horizontal: 24),
        shape:            RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
        backgroundColor:  AppColors.lightPrimary,
        foregroundColor:  Colors.white,
        disabledBackgroundColor: AppColors.lightPrimary.withValues(alpha: 0.38),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        padding:     const EdgeInsets.symmetric(horizontal: 24),
        shape:       RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
        side:        const BorderSide(color: AppColors.lightPrimary, width: 1.5),
        foregroundColor: AppColors.lightPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:      AppColors.lightSurface,
      selectedItemColor:    AppColors.lightPrimary,
      unselectedItemColor:  AppColors.lightTextSecondary,
      showUnselectedLabels: false,
      type:                 BottomNavigationBarType.fixed,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor:  AppColors.lightSurface,
      indicatorColor:   AppColors.lightPrimaryContainer,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.lightPrimary);
        }
        return const IconThemeData(color: AppColors.lightTextSecondary);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: AppColors.lightPrimary, fontSize: 12);
        }
        return const TextStyle(color: AppColors.lightTextSecondary, fontSize: 12);
      }),
    ),
  );
}
