import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/tokens/tokens.dart';

enum AppBannerTone { warning, danger, info }

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, required this.message, this.tone = AppBannerTone.warning, this.onDismiss});
  final String message;
  final AppBannerTone tone;
  final VoidCallback? onDismiss;

  ({Color bg, Color fg, IconData icon}) _palette() => switch (tone) {
    AppBannerTone.warning => (bg: AppColors.subtleWarningBg, fg: AppColors.warning, icon: LucideIcons.alertTriangle),
    AppBannerTone.danger => (bg: AppColors.subtleDangerBg, fg: AppColors.danger, icon: LucideIcons.alertCircle),
    AppBannerTone.info => (bg: AppColors.subtleNeutralBg, fg: AppColors.textPrimary, icon: LucideIcons.info),
  };

  @override
  Widget build(BuildContext context) {
    final p = _palette();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16, vertical: AppSpace.s12),
      decoration: BoxDecoration(color: p.bg, borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Row(children: [
        Icon(p.icon, size: 16, color: p.fg),
        const SizedBox(width: AppSpace.s12),
        Expanded(child: Text(message, style: AppText.small.copyWith(color: p.fg))),
        if (onDismiss != null) ...[
          const SizedBox(width: AppSpace.s8),
          GestureDetector(onTap: onDismiss, behavior: HitTestBehavior.opaque,
            child: Icon(LucideIcons.x, size: 14, color: p.fg)),
        ],
      ]),
    );
  }
}
