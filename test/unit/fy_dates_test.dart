import 'package:flutter_test/flutter_test.dart';
import 'package:pharma_pos/core/utils/fy_dates.dart';

void main() {
  group('FyDates', () {
    test('Apr 1 starts new FY', () {
      expect(FyDates.fyKey(DateTime(2025, 4, 1)), '2526');
      expect(FyDates.fyKey(DateTime(2025, 3, 31)), '2425');
    });
    test('Jan belongs to previous FY', () {
      expect(FyDates.fyKey(DateTime(2026, 1, 15)), '2526');
    });
    test('fyStart and fyEnd bracket correctly', () {
      final d = DateTime(2025, 11, 7);
      expect(FyDates.fyStart(d), DateTime(2025, 4, 1));
      expect(FyDates.fyEnd(d), DateTime(2026, 3, 31, 23, 59, 59, 999));
    });
    test('endOfMonth handles Dec', () {
      expect(FyDates.endOfMonth(DateTime(2026, 12, 5)).day, 31);
    });
    test('endOfMonth handles Feb leap', () {
      expect(FyDates.endOfMonth(DateTime(2028, 2, 1)).day, 29);
    });
  });
}
