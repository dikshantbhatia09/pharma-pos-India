import 'package:flutter_test/flutter_test.dart';
import 'package:pharma_pos/core/utils/money.dart';

void main() {
  group('Money.fromPaise', () {
    test('formats with rupee symbol and 2 decimals', () {
      expect(Money.fromPaise(0), '₹0.00');
      expect(Money.fromPaise(1), '₹0.01');
      expect(Money.fromPaise(100), '₹1.00');
      expect(Money.fromPaise(12345), '₹123.45');
    });
    test('uses Indian grouping', () {
      expect(Money.fromPaise(1234567), '₹12,345.67');
    });
  });
  group('Money.toPaise', () {
    test('parses clean string', () {
      expect(Money.toPaise('123.45'), 12345);
      expect(Money.toPaise('0'), 0);
    });
    test('strips symbols', () {
      expect(Money.toPaise('₹1,234.50'), 123450);
    });
    test('rejects bad input', () {
      expect(Money.toPaise(''), null);
      expect(Money.toPaise('abc'), null);
      expect(Money.toPaise('-5.00'), null);
    });
  });
}
