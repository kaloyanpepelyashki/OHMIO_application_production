import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTheme {
  final Color card1;
  final Color card2;
  final Color card3;
  final Color card4;

  CustomTheme({
    required this.card1,
    required this.card2,
    required this.card3,
    required this.card4
  });
}

extension CustomThemeData on ThemeData {
  CustomTheme get customTheme => CustomTheme(
        card1: Color(0xFFFACA91),
        card2: Color(0xFF98D9EE),
        card3: Color(0xFFF5B0CB),
        card4: Color(0xFF87D68D),
      );
}
