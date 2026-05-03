import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/tokens/tokens.dart';
import '../../core/utils/money.dart';
import '../../shared/widgets/widgets.dart';

class DesignSystemScreen extends StatelessWidget {
  const DesignSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System'),
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).maybePop()),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpace.s24, AppSpace.s8, AppSpace.s24, AppSpace.s64),
        children: const [
          _Section(title: 'Typography', child: _TypographySection()),
          _Section(title: 'Color', child: _ColorSection()),
          _Section(title: 'Spacing', child: _SpacingSection()),
          _Section(title: 'Buttons', child: _ButtonsSection()),
          _Section(title: 'Inputs', child: _InputsSection()),
          _Section(title: 'Search', child: _SearchSection()),
          _Section(title: 'Tags', child: _TagsSection()),
          _Section(title: 'Cards', child: _CardsSection()),
          _Section(title: 'Banner', child: _BannerSection()),
          _Section(title: 'Table', child: _TableSection()),
          _Section(title: 'Empty state', child: _EmptyStateSection()),
          _Section(title: 'Number pad', child: _NumberPadSection()),
          _Section(title: 'Dialog & sheet', child: _DialogSection()),
          _Section(title: 'Toast', child: _ToastSection()),
          _Section(title: 'Money', child: _MoneySection()),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: AppSpace.s40), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.toUpperCase(), style: AppText.caption.copyWith(color: AppColors.textTertiary)),
        const SizedBox(height: AppSpace.s12),
        AppCard(padding: const EdgeInsets.all(AppSpace.s20), child: child),
      ],
    ));
  }
}

class _TypographySection extends StatelessWidget {
  const _TypographySection();
  @override Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _t('display', 'Pharma POS', AppText.display),
      _t('h1', 'Daybook', AppText.h1),
      _t('h2', "Today's sales", AppText.h2),
      _t('body', 'Crocin Advance 500mg, strip of 15.', AppText.body),
      _t('body strong', 'Total ₹245.00', AppText.bodyStrong),
      _t('small', 'Last updated 2 minutes ago', AppText.small),
      _t('caption', 'STATUS', AppText.caption),
      _t('mono', '2526/0042', AppText.mono),
      _t('mono lg', '₹1,245.00', AppText.monoLg),
    ]);
  }
  Widget _t(String l, String t, TextStyle s) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpace.s16), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l, style: AppText.caption.copyWith(color: AppColors.textTertiary)),
        const SizedBox(height: AppSpace.s4), Text(t, style: s),
      ]));
}

class _ColorSection extends StatelessWidget {
  const _ColorSection();
  @override Widget build(BuildContext context) {
    final sw = <(String, Color)>[
      ('background', AppColors.background), ('surface', AppColors.surface),
      ('border', AppColors.border), ('borderStrong', AppColors.borderStrong),
      ('textPrimary', AppColors.textPrimary), ('textSecondary', AppColors.textSecondary),
      ('textTertiary', AppColors.textTertiary), ('accent', AppColors.accent),
      ('success', AppColors.success), ('warning', AppColors.warning),
      ('danger', AppColors.danger), ('subtleWarningBg', AppColors.subtleWarningBg),
      ('subtleDangerBg', AppColors.subtleDangerBg),
    ];
    return Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, children: [
      for (final (name, c) in sw) SizedBox(width: 140, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 48, decoration: BoxDecoration(color: c,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border, width: AppBorder.w))),
          const SizedBox(height: AppSpace.s8),
          Text(name, style: AppText.small),
          Text('#${c.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
            style: AppText.monoSm.copyWith(color: AppColors.textTertiary)),
        ])),
    ]);
  }
}

class _SpacingSection extends StatelessWidget {
  const _SpacingSection();
  @override Widget build(BuildContext context) {
    const sizes = [4.0, 8, 12, 16, 20, 24, 32, 40, 48, 64];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final s in sizes) Padding(padding: const EdgeInsets.only(bottom: AppSpace.s8),
        child: Row(children: [
          SizedBox(width: 56, child: Text('${s.toInt()}', style: AppText.monoSm)),
          Container(width: s, height: 16, color: AppColors.accent),
        ])),
    ]);
  }
}

class _ButtonsSection extends StatelessWidget {
  const _ButtonsSection();
  Widget _label(String s) => Padding(padding: const EdgeInsets.only(bottom: AppSpace.s8),
    child: Text(s.toUpperCase(), style: AppText.caption.copyWith(color: AppColors.textTertiary)));
  @override Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _label('Variants × md'),
      Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, children: [
        AppButton(label: 'Save invoice', onPressed: () {}),
        AppButton(label: 'Cancel', onPressed: () {}, variant: AppButtonVariant.secondary),
        AppButton(label: 'Edit', onPressed: () {}, variant: AppButtonVariant.ghost),
        AppButton(label: 'Void invoice', onPressed: () {}, variant: AppButtonVariant.danger),
      ]),
      const SizedBox(height: AppSpace.s24), _label('Sizes'),
      Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, crossAxisAlignment: WrapCrossAlignment.center, children: [
        AppButton(label: 'Small', onPressed: () {}, size: AppButtonSize.sm),
        AppButton(label: 'Medium', onPressed: () {}),
        AppButton(label: 'Large', onPressed: () {}, size: AppButtonSize.lg),
      ]),
      const SizedBox(height: AppSpace.s24), _label('With icons'),
      Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, children: [
        AppButton(label: 'Add product', onPressed: () {}, leadingIcon: LucideIcons.plus),
        AppButton(label: 'Print', onPressed: () {}, variant: AppButtonVariant.secondary, leadingIcon: LucideIcons.printer),
        AppButton(label: 'Continue', onPressed: () {}, trailingIcon: LucideIcons.arrowRight),
      ]),
      const SizedBox(height: AppSpace.s24), _label('States'),
      const Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, children: [
        AppButton(label: 'Disabled'),
        AppButton(label: 'Loading…', loading: true),
      ]),
      const SizedBox(height: AppSpace.s24), _label('Expanded'),
      AppButton(label: 'Save and print receipt', onPressed: () {},
        expand: true, size: AppButtonSize.lg, leadingIcon: LucideIcons.printer),
    ]);
  }
}

class _InputsSection extends StatelessWidget {
  const _InputsSection();
  @override Widget build(BuildContext context) {
    return Column(children: [
      const AppInput(label: 'Pharmacy name', placeholder: 'e.g. Sharma Medical Store',
        helper: 'Shown on every printed receipt.'),
      const SizedBox(height: AppSpace.s16),
      const AppInput(label: 'GSTIN', placeholder: '03AAACX0000Z1Z5',
        errorText: 'Enter a valid 15-character GSTIN.'),
      const SizedBox(height: AppSpace.s16),
      const AppInput(label: 'Phone', placeholder: '98765 43210', enabled: false, helper: 'Disabled state'),
      const SizedBox(height: AppSpace.s16),
      AppInput(label: 'MRP', placeholder: '0.00', textAlign: TextAlign.right, useMonoFont: true,
        leading: Text('₹', style: AppText.body.copyWith(color: AppColors.textTertiary))),
    ]);
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();
  @override Widget build(BuildContext context) {
    return Column(children: [
      AppSearchField(placeholder: 'Search products, generic, barcode…', shortcutHint: 'Ctrl K', onChanged: (_) {}),
      const SizedBox(height: AppSpace.s16),
      AppSearchField(placeholder: 'Find supplier…', onChanged: (_) {}),
    ]);
  }
}

class _TagsSection extends StatelessWidget {
  const _TagsSection();
  @override Widget build(BuildContext context) {
    return const Wrap(spacing: AppSpace.s8, runSpacing: AppSpace.s8, children: [
      AppTag(label: 'IN STOCK', tone: AppTagTone.success),
      AppTag(label: 'LOW STOCK', tone: AppTagTone.warning, icon: LucideIcons.alertTriangle),
      AppTag(label: 'EXPIRES SOON', tone: AppTagTone.warning),
      AppTag(label: 'EXPIRED', tone: AppTagTone.danger),
      AppTag(label: 'SCHEDULE H', tone: AppTagTone.danger),
      AppTag(label: 'GENERIC', tone: AppTagTone.neutral),
      AppTag(label: 'NEW', tone: AppTagTone.accent),
    ]);
  }
}

class _CardsSection extends StatelessWidget {
  const _CardsSection();
  @override Widget build(BuildContext context) {
    return Column(children: [
      AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Today's sales", style: AppText.h2),
          const AppTag(label: 'LIVE', tone: AppTagTone.success),
        ]),
        const SizedBox(height: AppSpace.s12),
        const MoneyText(245680, style: AppText.display),
        const SizedBox(height: AppSpace.s4),
        Text('42 invoices', style: AppText.small.copyWith(color: AppColors.textSecondary)),
      ])),
      const SizedBox(height: AppSpace.s12),
      AppCard(onTap: () {}, child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(
          color: AppColors.subtleNeutralBg, borderRadius: BorderRadius.circular(AppRadius.sm)),
          child: const Icon(LucideIcons.package2, size: 18)),
        const SizedBox(width: AppSpace.s12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Crocin Advance 500mg', style: AppText.bodyStrong),
          Text('Paracetamol • GSK', style: AppText.small.copyWith(color: AppColors.textSecondary)),
        ])),
        const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textTertiary),
      ])),
    ]);
  }
}

class _BannerSection extends StatelessWidget {
  const _BannerSection();
  @override Widget build(BuildContext context) {
    return const Column(children: [
      AppBanner(message: 'This bill contains Schedule H items. A prescription reference is required.',
        tone: AppBannerTone.warning),
      SizedBox(height: AppSpace.s12),
      AppBanner(message: '3 batches expired. Move them out of saleable stock.', tone: AppBannerTone.danger),
      SizedBox(height: AppSpace.s12),
      AppBanner(message: 'Backup completed at 10:42 PM.', tone: AppBannerTone.info),
    ]);
  }
}

class _TableSection extends StatelessWidget {
  const _TableSection();
  @override Widget build(BuildContext context) {
    return AppTable(
      columns: const [
        AppTableColumn(label: 'Product', flex: 3),
        AppTableColumn(label: 'Batch', flex: 2),
        AppTableColumn(label: 'Qty', numeric: true, flex: 1),
        AppTableColumn(label: 'MRP', numeric: true, flex: 1),
      ],
      rows: [
        AppTableRow(cells: [
          const Text('Crocin 500mg', style: AppText.bodyStrong),
          const Text('CRA221', style: AppText.monoSm),
          const Text('120', style: AppText.monoSm, textAlign: TextAlign.right),
          const MoneyText(2450, style: AppText.monoSm),
        ]),
        AppTableRow(cells: [
          const Text('Azithral 500', style: AppText.bodyStrong),
          const Text('AZ8821', style: AppText.monoSm),
          const Text('48', style: AppText.monoSm, textAlign: TextAlign.right),
          const MoneyText(8900, style: AppText.monoSm),
        ]),
      ],
    );
  }
}

class _EmptyStateSection extends StatelessWidget {
  const _EmptyStateSection();
  @override Widget build(BuildContext context) {
    return SizedBox(height: 280, child: AppEmptyState(
      icon: LucideIcons.search, title: 'No batches in stock',
      subtitle: 'Add a purchase entry to start tracking inventory for this product.',
      ctaLabel: 'Add purchase', onCta: () {},
    ));
  }
}

class _NumberPadSection extends StatefulWidget {
  const _NumberPadSection();
  @override State<_NumberPadSection> createState() => _NumberPadSectionState();
}

class _NumberPadSectionState extends State<_NumberPadSection> {
  String _value = '';
  void _handle(String key) {
    setState(() {
      if (key == 'BACK') { if (_value.isNotEmpty) _value = _value.substring(0, _value.length - 1); }
      else if (key == '.') { if (!_value.contains('.')) _value += '.'; }
      else { _value += key; }
    });
  }
  @override Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        padding: const EdgeInsets.all(AppSpace.s16),
        decoration: BoxDecoration(color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border, width: AppBorder.w)),
        child: Text(_value.isEmpty ? '0' : _value,
          style: AppText.monoLg.copyWith(fontSize: 24), textAlign: TextAlign.right),
      ),
      const SizedBox(height: AppSpace.s16),
      SizedBox(width: 280, child: AppNumberPad(onKey: _handle)),
    ]);
  }
}

class _DialogSection extends StatelessWidget {
  const _DialogSection();
  @override Widget build(BuildContext context) {
    return Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, children: [
      AppButton(label: 'Show dialog', variant: AppButtonVariant.secondary,
        onPressed: () => showAppDialog(context,
          title: 'Void this invoice?',
          body: const Text('This will reverse stock and mark invoice 2526/0042 as voided.'),
          primaryLabel: 'Void', onPrimary: () => Navigator.of(context).pop(),
          secondaryLabel: 'Cancel', onSecondary: () => Navigator.of(context).pop(),
          danger: true)),
      AppButton(label: 'Show bottom sheet', variant: AppButtonVariant.secondary,
        onPressed: () => showAppBottomSheet(context, title: 'Pick a batch',
          builder: (ctx) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.s24),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Crocin Advance 500mg has 2 batches in stock.',
                style: AppText.body.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: AppSpace.s16),
              AppCard(onTap: () => Navigator.of(ctx).pop(),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Batch CRA221', style: AppText.bodyStrong),
                    Text('Expires Mar 2027 • 120 in stock',
                      style: AppText.small.copyWith(color: AppColors.textSecondary)),
                  ])),
                  const AppTag(label: 'FEFO', tone: AppTagTone.success),
                ])),
              const SizedBox(height: AppSpace.s12),
              AppCard(onTap: () => Navigator.of(ctx).pop(),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Batch CRA198', style: AppText.bodyStrong),
                    Text('Expires Aug 2026 • 32 in stock',
                      style: AppText.small.copyWith(color: AppColors.textSecondary)),
                  ])),
                  const AppTag(label: 'EXPIRES SOON', tone: AppTagTone.warning),
                ])),
            ])))),
    ]);
  }
}

class _ToastSection extends StatelessWidget {
  const _ToastSection();
  @override Widget build(BuildContext context) {
    return Wrap(spacing: AppSpace.s12, runSpacing: AppSpace.s12, children: [
      AppButton(label: 'Neutral', size: AppButtonSize.sm, variant: AppButtonVariant.secondary,
        onPressed: () => AppToast.show(context, message: 'Backup saved.')),
      AppButton(label: 'Success', size: AppButtonSize.sm, variant: AppButtonVariant.secondary,
        onPressed: () => AppToast.show(context, message: 'Invoice saved and printed.', tone: AppToastTone.success)),
      AppButton(label: 'Warning', size: AppButtonSize.sm, variant: AppButtonVariant.secondary,
        onPressed: () => AppToast.show(context, message: '4 items expiring within 30 days.', tone: AppToastTone.warning)),
      AppButton(label: 'Danger', size: AppButtonSize.sm, variant: AppButtonVariant.secondary,
        onPressed: () => AppToast.show(context, message: 'Printer not connected.', tone: AppToastTone.danger)),
    ]);
  }
}

class _MoneySection extends StatelessWidget {
  const _MoneySection();
  @override Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Money: mono font, ₹ prefix, 2 decimals, right-aligned. Stored as paise (int).',
        style: AppText.small.copyWith(color: AppColors.textSecondary)),
      const SizedBox(height: AppSpace.s16),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Subtotal', style: AppText.body), MoneyText(124500, style: AppText.mono),
      ]),
      const SizedBox(height: AppSpace.s8),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('GST (12%)', style: AppText.body), MoneyText(13339, style: AppText.mono),
      ]),
      const SizedBox(height: AppSpace.s8),
      const Divider(height: AppBorder.w),
      const SizedBox(height: AppSpace.s8),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Total', style: AppText.bodyStrong), MoneyText(137839, style: AppText.monoLg),
      ]),
    ]);
  }
}
