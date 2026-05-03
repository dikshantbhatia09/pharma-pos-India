import 'package:flutter/material.dart';
import '../../core/theme/tokens/tokens.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child,
    this.padding = const EdgeInsets.all(AppSpace.s16), this.onTap, this.bordered = true});

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadius.lg),
        border: bordered ? Border.all(color: AppColors.border, width: AppBorder.w) : null,
      ),
      padding: padding, child: child,
    );
    if (onTap == null) return card;
    return _PressableCard(onTap: onTap!, child: card);
  }
}

class _PressableCard extends StatefulWidget {
  const _PressableCard({required this.onTap, required this.child});
  final VoidCallback onTap;
  final Widget child;
  @override State<_PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<_PressableCard> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap, behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.99 : 1.0, duration: AppMotion.fast, curve: AppMotion.curve,
        child: widget.child,
      ),
    );
  }
}
