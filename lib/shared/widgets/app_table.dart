import 'package:flutter/material.dart';
import '../../core/theme/tokens/tokens.dart';

enum AppTableDensity { dense, comfortable }

class AppTableColumn {
  const AppTableColumn({required this.label, this.flex = 1, this.numeric = false, this.width});
  final String label;
  final int flex;
  final bool numeric;
  final double? width;
}

class AppTableRow {
  const AppTableRow({required this.cells, this.onTap});
  final List<Widget> cells;
  final VoidCallback? onTap;
}

class AppTable extends StatelessWidget {
  const AppTable({super.key, required this.columns, required this.rows, this.density = AppTableDensity.comfortable});

  final List<AppTableColumn> columns;
  final List<AppTableRow> rows;
  final AppTableDensity density;

  double get _rowHeight => density == AppTableDensity.dense ? 40 : 48;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface, borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border, width: AppBorder.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Container(
          height: 40,
          decoration: const BoxDecoration(color: AppColors.background,
            border: Border(bottom: BorderSide(color: AppColors.border, width: AppBorder.w))),
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16),
          child: Row(children: [for (final c in columns) _headerCell(c)]),
        ),
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const Divider(height: AppBorder.w, thickness: AppBorder.w, color: AppColors.border),
          _rowWidget(rows[i]),
        ],
      ]),
    );
  }

  Widget _headerCell(AppTableColumn c) {
    final text = Text(c.label.toUpperCase(), style: AppText.caption.copyWith(color: AppColors.textTertiary),
      textAlign: c.numeric ? TextAlign.right : TextAlign.left);
    if (c.width != null) return SizedBox(width: c.width,
      child: Align(alignment: c.numeric ? Alignment.centerRight : Alignment.centerLeft, child: text));
    return Expanded(flex: c.flex,
      child: Align(alignment: c.numeric ? Alignment.centerRight : Alignment.centerLeft, child: text));
  }

  Widget _rowWidget(AppTableRow r) {
    final row = SizedBox(height: _rowHeight, child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16),
      child: Row(children: [for (var i = 0; i < columns.length; i++) _bodyCell(columns[i], r.cells[i])]),
    ));
    if (r.onTap == null) return row;
    return InkWell(onTap: r.onTap, hoverColor: AppColors.overlayHover,
      highlightColor: AppColors.overlayPress, splashFactory: NoSplash.splashFactory, child: row);
  }

  Widget _bodyCell(AppTableColumn c, Widget cell) {
    final aligned = Align(alignment: c.numeric ? Alignment.centerRight : Alignment.centerLeft, child: cell);
    if (c.width != null) return SizedBox(width: c.width, child: aligned);
    return Expanded(flex: c.flex, child: aligned);
  }
}
