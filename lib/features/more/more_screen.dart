import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/tokens/tokens.dart';
import '../../shared/widgets/widgets.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpace.s24, AppSpace.s8, AppSpace.s24, AppSpace.s64),
        children: [
          _row(LucideIcons.store, 'Pharmacy profile', () {}),
          _row(LucideIcons.printer, 'Printer pairing', () {}),
          _row(LucideIcons.calendar, 'Financial year', () {}),
          _row(LucideIcons.hardDrive, 'Backup', () {}),
          _row(LucideIcons.globe, 'Language', () {}),
          if (kDebugMode) ...[
            const SizedBox(height: AppSpace.s24),
            Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpace.s4),
              child: Text('DEVELOPER', style: AppText.caption.copyWith(color: AppColors.textTertiary))),
            const SizedBox(height: AppSpace.s8),
            _row(LucideIcons.palette, 'Design system', () => context.push('/dev/design-system')),
          ],
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, VoidCallback onTap) {
    return Padding(padding: const EdgeInsets.only(bottom: AppSpace.s8),
      child: AppCard(onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16, vertical: AppSpace.s12),
        child: Row(children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: AppSpace.s16),
          Expanded(child: Text(label, style: AppText.body)),
          const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textTertiary),
        ]),
      ),
    );
  }
}
