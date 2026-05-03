import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/tokens/tokens.dart';

class AppNumberPad extends StatelessWidget {
  const AppNumberPad({super.key, required this.onKey, this.allowDecimal = true});
  final ValueChanged<String> onKey;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    final keys = <List<_Key>>[
      [_Key.digit('1'), _Key.digit('2'), _Key.digit('3')],
      [_Key.digit('4'), _Key.digit('5'), _Key.digit('6')],
      [_Key.digit('7'), _Key.digit('8'), _Key.digit('9')],
      [allowDecimal ? _Key.digit('.') : _Key.disabled(), _Key.digit('0'), _Key.back()],
    ];
    return LayoutBuilder(builder: (_, c) {
      final cell = (c.maxWidth - 2 * AppSpace.s8) / 3;
      return Column(mainAxisSize: MainAxisSize.min, children: [
        for (var r = 0; r < keys.length; r++) ...[
          if (r > 0) const SizedBox(height: AppSpace.s8),
          Row(children: [
            for (var i = 0; i < keys[r].length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpace.s8),
              SizedBox(width: cell, height: cell.clamp(56, 80),
                child: _PadButton(keyData: keys[r][i],
                  onTap: keys[r][i].value == null ? null : () => onKey(keys[r][i].value!))),
            ],
          ]),
        ],
      ]);
    });
  }
}

class _Key {
  const _Key(this.value, {this.icon});
  final String? value;
  final IconData? icon;
  factory _Key.digit(String d) => _Key(d);
  factory _Key.back() => const _Key('BACK', icon: LucideIcons.delete);
  factory _Key.disabled() => const _Key(null);
}

class _PadButton extends StatefulWidget {
  const _PadButton({required this.keyData, this.onTap});
  final _Key keyData;
  final VoidCallback? onTap;
  @override State<_PadButton> createState() => _PadButtonState();
}

class _PadButtonState extends State<_PadButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null;
    return GestureDetector(
      onTapDown: disabled ? null : (_) => setState(() => _pressed = true),
      onTapUp: disabled ? null : (_) => setState(() => _pressed = false),
      onTapCancel: disabled ? null : () => setState(() => _pressed = false),
      onTap: widget.onTap, behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppMotion.fast, curve: AppMotion.curve,
        decoration: BoxDecoration(
          color: disabled ? AppColors.background : _pressed ? AppColors.subtleNeutralBg : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border, width: AppBorder.w),
        ),
        alignment: Alignment.center,
        child: widget.keyData.icon != null
          ? Icon(widget.keyData.icon, size: 22, color: disabled ? AppColors.textTertiary : AppColors.textPrimary)
          : Text(widget.keyData.value ?? '', style: AppText.monoLg.copyWith(fontSize: 22,
              color: disabled ? AppColors.textTertiary : AppColors.textPrimary)),
      ),
    );
  }
}
