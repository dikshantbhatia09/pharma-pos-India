import 'package:flutter/material.dart';
import '../../core/theme/tokens/tokens.dart';
import 'app_button.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, required this.icon, required this.title,
    this.subtitle, this.ctaLabel, this.onCta});

  final IconData icon;
  final String title;
  final String? subtitle, ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(AppSpace.s24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 320),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 32, color: AppColors.textTertiary),
          const SizedBox(height: AppSpace.s16),
          Text(title, style: AppText.h2, textAlign: TextAlign.center),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpace.s8),
            Text(subtitle!, style: AppText.body.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
          ],
          if (ctaLabel != null && onCta != null) ...[
            const SizedBox(height: AppSpace.s24),
            AppButton(label: ctaLabel!, onPressed: onCta, variant: AppButtonVariant.secondary),
          ],
        ]),
      ),
    ));
  }
}
