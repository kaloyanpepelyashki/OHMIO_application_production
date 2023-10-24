import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/config/themes/custom_theme.dart';

Color getColorFromThemeColor(String color, BuildContext context) {
    switch (color!) {
      case 'card1':
        return Theme.of(context).customTheme.card1;
      case 'card2':
        return Theme.of(context).customTheme.card2;
      case 'card3':
        return Theme.of(context).customTheme.card3;
      case 'card4':
        return Theme.of(context).customTheme.card4;
      default:
        return Colors.transparent; // or any default color
    }
  }