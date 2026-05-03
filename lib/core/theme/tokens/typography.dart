import 'package:flutter/painting.dart';
import 'colors.dart';

class AppText {
  AppText._();

  static const String _ui = 'Inter';
  static const String _mono = 'JetBrainsMono';

  static const TextStyle display = TextStyle(
    fontFamily: _ui, fontSize: 32, height: 40 / 32,
    fontWeight: FontWeight.w600, letterSpacing: -0.64,
    color: AppColors.textPrimary,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: _ui, fontSize: 24, height: 32 / 24,
    fontWeight: FontWeight.w600, letterSpacing: -0.24,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _ui, fontSize: 18, height: 28 / 18,
    fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _ui, fontSize: 15, height: 22 / 15,
    fontWeight: FontWeight.w400, color: AppColors.textPrimary,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontFamily: _ui, fontSize: 15, height: 22 / 15,
    fontWeight: FontWeight.w500, color: AppColors.textPrimary,
  );

  static const TextStyle small = TextStyle(
    fontFamily: _ui, fontSize: 13, height: 18 / 13,
    fontWeight: FontWeight.w400, color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _ui, fontSize: 12, height: 16 / 12,
    fontWeight: FontWeight.w500, letterSpacing: 0.24,
    color: AppColors.textSecondary,
  );

  static const TextStyle mono = TextStyle(
    fontFamily: _mono, fontSize: 14, height: 20 / 14,
    fontWeight: FontWeight.w500, color: AppColors.textPrimary,
  );

  static const TextStyle monoLg = TextStyle(
    fontFamily: _mono, fontSize: 16, height: 22 / 16,
    fontWeight: FontWeight.w500, color: AppColors.textPrimary,
  );

  static const TextStyle monoSm = TextStyle(
    fontFamily: _mono, fontSize: 13, height: 18 / 13,
    fontWeight: FontWeight.w500, color: AppColors.textPrimary,
  );
}
