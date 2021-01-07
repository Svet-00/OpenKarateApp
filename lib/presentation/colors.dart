import 'dart:math';

import 'package:flutter/material.dart';

class BrandColors {
  BrandColors._();
  static final Color error = Color(0xFFB00020);
  static final Color success = Colors.green.shade700;
  static final Color greyBackground = Colors.grey.shade300;
  static final Color greyText = Colors.grey.shade500;
}

extension ColorX on Color {
  Color lighten([int percent = 10]) {
    assert(percent <= 90);
    final k = (100 + percent) / 100;
    final calc = (int v) => min(255, (v * k).round());
    return Color.fromARGB(
      alpha,
      calc(red),
      calc(green),
      calc(blue),
    );
  }
}
