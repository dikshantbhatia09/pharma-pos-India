import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/tokens/tokens.dart';

enum AppToastTone { neutral, success, warning, danger }

class AppToast {
  AppToast._();
  static OverlayEntry? _current;
  static Timer? _timer;

  static void show(BuildContext context, {required String message, AppToastTone tone = AppToastTone.neutral}) {
    _current?.remove();
    _timer?.cancel();
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(builder: (_) => _ToastView(message: message, tone: tone));
    _current = entry;
    overlay.insert(entry);
    _timer = Timer(const Duration(seconds: 3), () { entry.remove(); if (_current == entry) _current = null; });
  }
}

class _ToastView extends StatefulWidget {
  const _ToastView({required this.message, required this.tone});
  final String message;
  final AppToastTone tone;
  @override State<_ToastView> createState() => _ToastViewState();
}

class _ToastViewState extends State<_ToastView> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: AppMotion.slow)..forward();

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  ({Color bg, Color fg, IconData icon}) _palette() => switch (widget.tone) {
    AppToastTone.neutral => (bg: AppColors.surface, fg: AppColors.textPrimary, icon: LucideIcons.info),
    AppToastTone.success => (bg: AppColors.surface, fg: AppColors.success, icon: LucideIcons.check),
    AppToastTone.warning => (bg: AppColors.surface, fg: AppColors.warning, icon: LucideIcons.alertTriangle),
    AppToastTone.danger => (bg: AppColors.surface, fg: AppColors.danger, icon: LucideIcons.alertCircle),
  };

  @override
  Widget build(BuildContext context) {
    final p = _palette();
    final mq = MediaQuery.of(context);
    return Positioned(
      top: mq.padding.top + AppSpace.s12, left: AppSpace.s24, right: AppSpace.s24,
      child: FadeTransition(opacity: CurvedAnimation(parent: _ctrl, curve: AppMotion.curve),
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero)
            .animate(CurvedAnimation(parent: _ctrl, curve: AppMotion.curve)),
          child: Material(color: Colors.transparent, child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16, vertical: AppSpace.s12),
            decoration: BoxDecoration(color: p.bg, borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border, width: AppBorder.w)),
            child: Row(children: [
              Icon(p.icon, size: 18, color: p.fg),
              const SizedBox(width: AppSpace.s12),
              Expanded(child: Text(widget.message, style: AppText.body)),
            ]),
          )),
        ),
      ),
    );
  }
}
