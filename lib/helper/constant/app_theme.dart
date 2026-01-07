import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  final Color primarye;
  final Color secondary;
  final Color thirdly;
  final Color fourthly;
  final Color error;
  final Color success;

  const AppTheme({
    required this.primarye,
    required this.secondary,
    required this.thirdly,
    required this.fourthly,
    required this.error,
    required this.success,
  });

  @override
  AppTheme copyWith({
    Color? primary,
    Color? secondary,
    Color? thirdly,
    Color? fourthly,
    Color? error,
    Color? success,
  }) {
    return AppTheme(
      primarye: primary ?? this.primarye,
      secondary: secondary ?? this.secondary,
      thirdly: thirdly ?? this.thirdly,
      fourthly: fourthly ?? this.fourthly,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(
      primarye: Color.lerp(primarye, other.primarye, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      thirdly: Color.lerp(thirdly, other.thirdly, t)!,
      fourthly: Color.lerp(fourthly, other.fourthly, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

extension AppThemeGetter on BuildContext {
  // Safe getter: Returns a default if the theme isn't found
  AppTheme get appTheme {
    final theme = Theme.of(this).extension<AppTheme>();
    if (theme == null) {
      // LOG THE ERROR instead of crashing
      debugPrint("WARNING: AppTheme not found in this context!");
      return const AppTheme(
        primarye: Colors.black, // Near black
        secondary: Color(0xFF757575), // Medium Grey
        thirdly: Color(0xFFF5F5F5), // Off-white
        fourthly: Color(0xFF2196F3), // Blue Accent
        error: Color(0xFFD32F2F), // Material Red 700
        success: Color(0xFF388E3C), // Material Green 700
      );
    }
    return theme;
  }
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  extensions: const [
    AppTheme(
      primarye: Colors.black, // Near black
      secondary: Color(0xFF757575), // Medium Grey
      thirdly: Color(0xFFF5F5F5), // Off-white
      fourthly: Color(0xFF2196F3), // Blue Accent
      error: Color(0xFFD32F2F), // Material Red 700
      success: Color(0xFF388E3C), // Material Green 700
    ),
  ],
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  extensions: const [
    AppTheme(
      primarye: Colors.white,
      secondary: Color(0xFFBDBDBD), // Light Grey
      thirdly: Color(0xFF121212), // Dark Surface
      fourthly: Color(0xFF90CAF9), // Light Blue Accent
      error: Color(0xFFEF9A9A), // Material Red 200
      success: Color(0xFFA5D6A7), // Material Green 200
    ),
  ],
);
