class FyDates {
  FyDates._();

  static (String, String) fyShortPair(DateTime d) {
    final startYear = d.month >= 4 ? d.year : d.year - 1;
    final endYear = startYear + 1;
    return (
      (startYear % 100).toString().padLeft(2, '0'),
      (endYear % 100).toString().padLeft(2, '0'),
    );
  }

  static String fyKey(DateTime d) {
    final (a, b) = fyShortPair(d);
    return '$a$b';
  }

  static DateTime fyStart(DateTime d) {
    final startYear = d.month >= 4 ? d.year : d.year - 1;
    return DateTime(startYear, 4, 1);
  }

  static DateTime fyEnd(DateTime d) {
    final startYear = d.month >= 4 ? d.year : d.year - 1;
    return DateTime(startYear + 1, 3, 31, 23, 59, 59, 999);
  }

  static DateTime endOfMonth(DateTime d) {
    final firstOfNext = (d.month == 12)
        ? DateTime(d.year + 1, 1, 1)
        : DateTime(d.year, d.month + 1, 1);
    return firstOfNext.subtract(const Duration(seconds: 1));
  }
}
