import 'package:flutter/material.dart';
import '../../core/theme/tokens/tokens.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }
enum AppButtonSize { sm, md, lg }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key, required this.label, this.onPressed,
    this.variant = AppButtonVariant.primary, this.size = AppButtonSize.md,
    this.leadingIcon, this.trailingIcon, this.loading = false, this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool loading;
  final bool expand;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;
  bool get _disabled => widget.onPressed == null || widget.loading;

  double get _visualHeight => switch (widget.size) {
    AppButtonSize.sm => 32, AppButtonSize.md => 40, AppButtonSize.lg => 48,
  };

  EdgeInsets get _padding => switch (widget.size) {
    AppButtonSize.sm => const EdgeInsets.symmetric(horizontal: AppSpace.s12),
    AppButtonSize.md => const EdgeInsets.symmetric(horizontal: AppSpace.s16),
    AppButtonSize.lg => const EdgeInsets.symmetric(horizontal: AppSpace.s20),
  };

  TextStyle get _textStyle => switch (widget.size) {
    AppButtonSize.sm => AppText.small.copyWith(fontWeight: FontWeight.w500),
    AppButtonSize.md => AppText.bodyStrong,
    AppButtonSize.lg => AppText.bodyStrong,
  };

  double get _iconSize => switch (widget.size) {
    AppButtonSize.sm => 16, AppButtonSize.md => 18, AppButtonSize.lg => 20,
  };

  ({Color bg, Color fg, Color? border}) _palette() {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return (bg: _disabled ? AppColors.borderStrong : AppColors.accent,
                fg: AppColors.accentForeground, border: null);
      case AppButtonVariant.secondary:
        return (bg: AppColors.surface,
                fg: _disabled ? AppColors.textTertiary : AppColors.textPrimary,
                border: AppColors.border);
      case AppButtonVariant.ghost:
        return (bg: Colors.transparent,
                fg: _disabled ? AppColors.textTertiary : AppColors.textPrimary,
                border: null);
      case AppButtonVariant.danger:
        return (bg: _disabled ? AppColors.borderStrong : AppColors.danger,
                fg: AppColors.accentForeground, border: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = _palette();
    // ignore: deprecated_member_use
    final pressOverlay = _pressed && !_disabled
        ? (widget.variant == AppButtonVariant.primary || widget.variant == AppButtonVariant.danger
            ? Colors.black.withOpacity(0.10)
            : AppColors.overlayPress)
        : Colors.transparent;

    final child = AnimatedContainer(
      duration: AppMotion.fast, curve: AppMotion.curve,
      height: _visualHeight, padding: _padding,
      decoration: BoxDecoration(
        color: Color.alphaBlend(pressOverlay, p.bg),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: p.border != null ? Border.all(color: p.border!, width: AppBorder.w) : null,
      ),
      child: Row(
        mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.loading)
            SizedBox(width: _iconSize, height: _iconSize,
              child: CircularProgressIndicator(strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation(p.fg)))
          else if (widget.leadingIcon != null)
            Icon(widget.leadingIcon, size: _iconSize, color: p.fg),
          if (widget.loading || widget.leadingIcon != null) const SizedBox(width: AppSpace.s8),
          Flexible(child: Text(widget.label, style: _textStyle.copyWith(color: p.fg),
            overflow: TextOverflow.ellipsis, softWrap: false)),
          if (widget.trailingIcon != null) ...[
            const SizedBox(width: AppSpace.s8),
            Icon(widget.trailingIcon, size: _iconSize, color: p.fg),
          ],
        ],
      ),
    );

    return Semantics(
      button: true, enabled: !_disabled, label: widget.label,
      child: GestureDetector(
        onTapDown: _disabled ? null : (_) => setState(() => _pressed = true),
        onTapUp: _disabled ? null : (_) => setState(() => _pressed = false),
        onTapCancel: _disabled ? null : () => setState(() => _pressed = false),
        onTap: _disabled ? null : widget.onPressed,
        behavior: HitTestBehavior.opaque,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Center(
            child: widget.expand ? SizedBox(width: double.infinity, child: child) : child,
          ),
        ),
      ),
    );
  }
}
