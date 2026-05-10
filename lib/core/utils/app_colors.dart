import 'package:flutter/material.dart';

class AppColors {
  static bool _isDark = true;

  static const Color darkScaffold = Color(0xff10131a);
  static const Color lightScaffold = Color(0xfff6f7fb);
  static const Color primary = Color(0xff1a73e8);
  static const Color purple = Color(0xff7c4dff);

  static void setIsDark(bool isDark) {
    _isDark = isDark;
  }

  static Color get scaffold => _isDark ? darkScaffold : lightScaffold;

  static Color get registerScaffold =>
      _isDark ? const Color(0xff0f0f1a) : const Color(0xffeef2ff);

  static Color get card => _isDark ? const Color(0xb31c1c2e) : Colors.white;

  static Color get input =>
      _isDark ? const Color(0xff272a31) : const Color(0xffeef1f7);

  static Color get registerInput =>
      _isDark ? const Color(0xff0b0e15) : const Color(0xfff8f9fd);

  static Color get border =>
      _isDark ? const Color(0x1affffff) : const Color(0x1a0f172a);

  static Color get mutedBorder =>
      _isDark ? const Color(0x4d414754) : const Color(0xffd6dce8);

  static Color get accent =>
      _isDark ? const Color(0xffadc7ff) : const Color(0xff1557b0);

  static Color get title =>
      _isDark ? const Color(0xffe0e2ec) : const Color(0xff172033);

  static Color get body =>
      _isDark ? const Color(0xffc1c6d6) : const Color(0xff4d5870);

  static Color get hint =>
      _isDark ? const Color(0xff8b909f) : const Color(0xff7a8498);
}
