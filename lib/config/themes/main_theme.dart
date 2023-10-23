import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      //primary: const Color(0xFF551C50),
      primary: const Color(0xFFFFFFFF),
      secondary: const Color(0xFF7B44B1),
      //In this case this is the color of text
      tertiary: const Color(0xFF3E2A35),
      //secondary: const Color.fromARGB(11, 210, 112, 14),
      background: Color(0xFF3B2B4B),

      // background: const Color(0xFFFAFAFA),
    ),
    typography: Typography());
