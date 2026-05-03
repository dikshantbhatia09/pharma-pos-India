import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/tokens/tokens.dart';
import 'app_input.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({super.key, this.placeholder = 'Search…', this.onChanged,
    this.onSubmitted, this.controller, this.focusNode, this.shortcutHint, this.autofocus = false});

  final String placeholder;
  final ValueChanged<String>? onChanged, onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? shortcutHint;
  final bool autofocus;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _ownsController = widget.controller == null;
    _controller.addListener(_rebuild);
  }
  void _rebuild() { if (mounted) setState(() {}); }

  @override
  void dispose() {
    _controller.removeListener(_rebuild);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;
    Widget? trailing;
    if (hasText) {
      trailing = GestureDetector(
        onTap: () { _controller.clear(); widget.onChanged?.call(''); },
        behavior: HitTestBehavior.opaque,
        child: const Padding(padding: EdgeInsets.all(AppSpace.s4),
          child: Icon(LucideIcons.x, size: 16, color: AppColors.textTertiary)),
      );
    } else if (widget.shortcutHint != null) {
      trailing = Container(
        margin: const EdgeInsets.only(right: AppSpace.s4),
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.s8, vertical: 2),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border, width: AppBorder.w)),
        child: Text(widget.shortcutHint!, style: AppText.caption.copyWith(color: AppColors.textTertiary)),
      );
    }
    return AppInput(
      controller: _controller, focusNode: widget.focusNode, placeholder: widget.placeholder,
      onChanged: widget.onChanged, onSubmitted: widget.onSubmitted, autofocus: widget.autofocus,
      leading: const Icon(LucideIcons.search), trailing: trailing,
    );
  }
}
