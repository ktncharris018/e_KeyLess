import 'package:flutter/material.dart';

class ColorUtils {
  /// Aplica opacidad al color usando alpha (0 - 255)
  static Color applyOpacity(Color color, double opacity) {
    final alpha = (opacity * 255).clamp(0, 255).toInt();
    return color.withAlpha(alpha);
  }
}
