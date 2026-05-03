import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/tokens/tokens.dart';
import '../../core/utils/money.dart';
import '../../shared/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Text('Sharma Medical'),
          const SizedBox(width: AppSpace.s8),
          Container(width: 6, height: 6, decoration: const BoxDecoration(
            color: AppColors.success, shape: BoxShape.circle)),
        ]),
        actions: [
          if (kDebugMode) IconButton(
            icon: const Icon(LucideIcons.palette), tooltip: 'Design system',
            onPressed: () => context.push('/dev/design-system'),
          ),
          IconButton(icon: const Icon(LucideIcons.settings), onPressed: () => context.go('/more')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpace.s24, AppSpace.s8, AppSpace.s24, AppSpace.s64),
        children: [
          AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('TODAY', style: AppText.caption.copyWith(color: AppColors.textTertiary)),
              Text('Sun, May 03', style: AppText.small.copyWith(color: AppColors.textTertiary)),
            ]),
            const SizedBox(height: AppSpace.s12),
            const MoneyText(0, style: AppText.display),
            const SizedBox(height: AppSpace.s4),
            Text('0 invoices', style: AppText.small.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpace.s20),
            AppButton(label: 'New bill', onPressed: () => context.go('/bill'),
              expand: true, size: AppButtonSize.lg, leadingIcon: LucideIcons.plus),
          ])),
          const SizedBox(height: AppSpace.s12),
          Row(children: [
            Expanded(child: AppCard(onTap: () => context.go('/inventory'),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(LucideIcons.alertTriangle, size: 18, color: AppColors.warning),
                const SizedBox(height: AppSpace.s12),
                Text('Low stock', style: AppText.caption.copyWith(color: AppColors.textTertiary)),
                const SizedBox(height: AppSpace.s4),
                const Text('—', style: AppText.h1),
              ]))),
            const SizedBox(width: AppSpace.s12),
            Expanded(child: AppCard(onTap: () => context.go('/inventory'),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(LucideIcons.clock, size: 18, color: AppColors.danger),
                const SizedBox(height: AppSpace.s12),
                Text('Expiring 30d', style: AppText.caption.copyWith(color: AppColors.textTertiary)),
                const SizedBox(height: AppSpace.s4),
                const Text('—', style: AppText.h1),
              ]))),
          ]),
          const SizedBox(height: AppSpace.s24),
          Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpace.s4),
            child: Text('RECENT INVOICES', style: AppText.caption.copyWith(color: AppColors.textTertiary))),
          const SizedBox(height: AppSpace.s8),
          SizedBox(height: 240, child: AppEmptyState(
            icon: LucideIcons.receipt, title: 'No invoices yet',
            subtitle: 'Your first bill will show up here.',
            ctaLabel: 'Start a bill', onCta: () => context.go('/bill'),
          )),
        ],
      ),
    );
  }
}
