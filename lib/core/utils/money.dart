import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../theme/tokens/tokens.dart';

class Money {
  Money._();

  static final NumberFormat _inr = NumberFormat.currency(
    locale: 'en_IN', symbol: '₹', decimalDigits: 2,
  );

  static String fromPaise(int paise) => _inr.format(paise / 100);

  static int? toPaise(String input) {
    final cleaned = input.replaceAll('₹', '').replaceAll(',', '').trim();
    if (cleaned.isEmpty) return null;
    final v = double.tryParse(cleaned);
    if (v == null || v < 0) return null;
    return (v * 100).round();
  }
}

class MoneyText extends StatelessWidget {
  const MoneyText(this.paise, {super.key, this.style, this.color});

  final int paise;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      Money.fromPaise(paise),
      textAlign: TextAlign.right,
      style: (style ?? AppText.mono).copyWith(color: color),
    );
  }
}
