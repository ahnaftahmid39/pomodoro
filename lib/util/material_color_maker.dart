import 'package:flutter/material.dart';

MaterialColor getMaterialcolor(Color clr) {
  Map<int, Color> swatch = {
    50: clr.withOpacity(0.1),
    100: clr.withOpacity(0.2),
    200: clr.withOpacity(0.3),
    300: clr.withOpacity(0.4),
    400: clr.withOpacity(0.5),
    500: clr.withOpacity(0.6),
    600: clr.withOpacity(0.7),
    700: clr.withOpacity(0.8),
    800: clr.withOpacity(0.9),
    900: clr.withOpacity(1),
  };
  return MaterialColor(clr.value, swatch);
}
