import 'package:flutter/material.dart';
import '../../core/theme/tokens/tokens.dart';

enum AppTagTone { neutral, success, warning, danger, accent }

class AppTag extends StatelessWidget {
  const AppTag({super.key, required this.label, this.tone = AppTagTone.neutral, this.icon});

  final String label;
  final AppTagTone tone;
  final IconData? icon;

  ({Color bg, Color fg}) _palette() => switch (tone) {
    AppTagTone.neutral => (bg: AppColors.subtleNeutralBg, fg: AppColors.textSecondary),
    AppTagTone.success => (bg: AppColors.subtleSuccessBg, fg: AppColors.success),
    AppTagTone.warning => (bg: AppColors.subtleWarningBg, fg: AppColors.warning),
    AppTagTone.danger => (bg: AppColors.subtleDangerBg, fg: AppColors.danger),
    AppTagTone.accent => (bg: AppColors.accent, fg: AppColors.accentForeground),
  };

  @override
  Widget build(BuildContext context) {
    final p = _palette();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s8, vertical: 2),
      decoration: BoxDecoration(color: p.bg, borderRadius: BorderRadius.circular(AppRadius.pill)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 12, color: p.fg), const SizedBox(width: AppSpace.s4)],
        Text(label, style: AppText.caption.copyWith(color: p.fg)),
      ]),
    );
  }
}
