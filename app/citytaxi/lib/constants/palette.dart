import 'package:flutter/material.dart';

class Palette {
  static Color mainColor10 = const Color(0xFF8500ED);

  static Color mainColor30 = const Color(0xFF6C97B1);

  static Color mainColor60 = const Color(0xFF3A2A46);

  static Color white = const Color(0xFFFFFFFF);

  static Color black = const Color(0xFF000000);

  static Color green = const Color(0xFF74C790);

  static Color red = const Color(0xFFFB6C6C);

  static Color yellow = const Color(0xFFFFCC00);

  static Gradient topBarGradient = LinearGradient(
    colors: [Palette.mainColor30, Palette.mainColor10],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 1.3653],
  );
}
