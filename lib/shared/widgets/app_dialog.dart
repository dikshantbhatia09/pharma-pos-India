import 'package:flutter/material.dart';
import '../../core/theme/tokens/tokens.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({super.key, required this.title, required this.body,
    this.primaryAction, this.secondaryAction, this.danger = false});

  final String title;
  final Widget body;
  final _DialogAction? primaryAction;
  final _DialogAction? secondaryAction;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpace.s24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: AppColors.border, width: AppBorder.w),
          ),
          padding: const EdgeInsets.all(AppSpace.s24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(title, style: AppText.h2),
            const SizedBox(height: AppSpace.s12),
            DefaultTextStyle(style: AppText.body.copyWith(color: AppColors.textSecondary), child: body),
            const SizedBox(height: AppSpace.s24),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              if (secondaryAction != null) ...[
                AppButton(label: secondaryAction!.label, onPressed: secondaryAction!.onPressed, variant: AppButtonVariant.secondary),
                const SizedBox(width: AppSpace.s12),
              ],
              if (primaryAction != null)
                AppButton(label: primaryAction!.label, onPressed: primaryAction!.onPressed,
                  variant: danger ? AppButtonVariant.danger : AppButtonVariant.primary),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _DialogAction {
  const _DialogAction(this.label, this.onPressed);
  final String label;
  final VoidCallback? onPressed;
}

Future<T?> showAppDialog<T>(BuildContext context, {
  required String title, required Widget body,
  String? primaryLabel, VoidCallback? onPrimary,
  String? secondaryLabel, VoidCallback? onSecondary,
  bool danger = false, bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context, barrierDismissible: barrierDismissible,
    // ignore: deprecated_member_use
    barrierColor: Colors.black.withOpacity(0.32),
    builder: (_) => AppDialog(title: title, body: body, danger: danger,
      primaryAction: primaryLabel == null ? null : _DialogAction(primaryLabel, onPrimary),
      secondaryAction: secondaryLabel == null ? null : _DialogAction(secondaryLabel, onSecondary)),
  );
}

Future<T?> showAppBottomSheet<T>(BuildContext context, {
  required Widget Function(BuildContext) builder,
  String? title, bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context, backgroundColor: Colors.transparent,
    // ignore: deprecated_member_use
    barrierColor: Colors.black.withOpacity(0.32),
    isScrollControlled: isScrollControlled,
    builder: (ctx) => Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(topLeft: AppRadius.rLg, topRight: AppRadius.rLg),
        border: Border(
          top: BorderSide(color: AppColors.border, width: AppBorder.w),
          left: BorderSide(color: AppColors.border, width: AppBorder.w),
          right: BorderSide(color: AppColors.border, width: AppBorder.w),
        ),
      ),
      child: SafeArea(top: false, child: Column(
        mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpace.s12),
          Center(child: Container(width: 36, height: 4,
            decoration: BoxDecoration(color: AppColors.borderStrong, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: AppSpace.s12),
          if (title != null) ...[
            Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpace.s24), child: Text(title, style: AppText.h2)),
            const SizedBox(height: AppSpace.s16),
          ],
          Flexible(child: builder(ctx)),
          const SizedBox(height: AppSpace.s16),
        ],
      )),
    ),
  );
}
