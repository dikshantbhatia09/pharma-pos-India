import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/tokens/tokens.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key, this.label, this.helper, this.errorText, this.placeholder,
    this.controller, this.focusNode, this.leading, this.trailing,
    this.keyboardType, this.inputFormatters, this.obscureText = false,
    this.enabled = true, this.autofocus = false, this.onChanged,
    this.onSubmitted, this.textAlign = TextAlign.start,
    this.useMonoFont = false, this.maxLines = 1,
  });

  final String? label, helper, errorText, placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? leading, trailing;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText, enabled, autofocus, useMonoFont;
  final ValueChanged<String>? onChanged, onSubmitted;
  final TextAlign textAlign;
  final int maxLines;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late final FocusNode _focusNode;
  bool _ownsFocusNode = false;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() { if (mounted) setState(() => _focused = _focusNode.hasFocus); }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final borderColor = hasError ? AppColors.danger : _focused ? AppColors.textPrimary : AppColors.border;
    final bg = widget.enabled ? AppColors.surface : AppColors.subtleNeutralBg;
    final textStyle = widget.useMonoFont ? AppText.mono : AppText.body;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppText.small.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpace.s8),
        ],
        AnimatedContainer(
          duration: AppMotion.fast, curve: AppMotion.curve,
          decoration: BoxDecoration(
            color: bg, borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: borderColor, width: AppBorder.w),
          ),
          child: Row(
            children: [
              if (widget.leading != null) ...[
                const SizedBox(width: AppSpace.s12),
                IconTheme(data: const IconThemeData(size: 18, color: AppColors.textTertiary), child: widget.leading!),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller, focusNode: _focusNode,
                  keyboardType: widget.keyboardType, inputFormatters: widget.inputFormatters,
                  obscureText: widget.obscureText, enabled: widget.enabled,
                  autofocus: widget.autofocus, onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted, textAlign: widget.textAlign,
                  maxLines: widget.maxLines, cursorColor: AppColors.textPrimary,
                  cursorWidth: 1.5, style: textStyle,
                  decoration: InputDecoration(
                    isDense: true, border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpace.s12, vertical: AppSpace.s12),
                    hintText: widget.placeholder, hintStyle: textStyle.copyWith(color: AppColors.textTertiary),
                  ),
                ),
              ),
              if (widget.trailing != null) ...[
                IconTheme(data: const IconThemeData(size: 18, color: AppColors.textTertiary), child: widget.trailing!),
                const SizedBox(width: AppSpace.s12),
              ],
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: AppSpace.s8),
          Text(widget.errorText!, style: AppText.small.copyWith(color: AppColors.danger)),
        ] else if (widget.helper != null) ...[
          const SizedBox(height: AppSpace.s8),
          Text(widget.helper!, style: AppText.small.copyWith(color: AppColors.textTertiary)),
        ],
      ],
    );
  }
}
