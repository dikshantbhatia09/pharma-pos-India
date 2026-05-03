import 'package:flutter/material.dart';
import 'tokens/tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        onPrimary: AppColors.accentForeground,
        secondary: AppColors.accent,
        onSecondary: AppColors.accentForeground,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.danger,
        onError: AppColors.accentForeground,
        outline: AppColors.border,
        outlineVariant: AppColors.borderStrong,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppText.h2,
      ),
      textTheme: const TextTheme(
        displayLarge: AppText.display,
        displayMedium: AppText.display,
        headlineLarge: AppText.h1,
        headlineMedium: AppText.h1,
        headlineSmall: AppText.h2,
        titleLarge: AppText.h2,
        titleMedium: AppText.bodyStrong,
        bodyLarge: AppText.body,
        bodyMedium: AppText.body,
        bodySmall: AppText.small,
        labelLarge: AppText.bodyStrong,
        labelMedium: AppText.small,
        labelSmall: AppText.caption,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 20),
      dividerTheme: const DividerThemeData(
        color: AppColors.border, thickness: AppBorder.w, space: AppBorder.w,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: AppColors.overlayHover,
      visualDensity: VisualDensity.standard,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _FadePageTransitionsBuilder(),
          TargetPlatform.iOS: _FadePageTransitionsBuilder(),
        },
      ),
    );
  }
}

class _FadePageTransitionsBuilder extends PageTransitionsBuilder {
  const _FadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route, BuildContext context,
    Animation<double> animation, Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: AppMotion.curve),
      child: child,
    );
  }
}
