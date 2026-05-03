import 'package:flutter/painting.dart';

class AppRadius {
  AppRadius._();
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 14;
  static const double xl = 20;
  static const double pill = 999;
  static const Radius rSm = Radius.circular(sm);
  static const Radius rMd = Radius.circular(md);
  static const Radius rLg = Radius.circular(lg);
  static const Radius rXl = Radius.circular(xl);
}

class AppMotion {
  AppMotion._();
  static const Duration fast = Duration(milliseconds: 80);
  static const Duration base = Duration(milliseconds: 120);
  static const Duration slow = Duration(milliseconds: 150);
  static const Curve curve = Curves.easeOutCubic;
}

class AppBorder {
  AppBorder._();
  static const double w = 1.0;
}
