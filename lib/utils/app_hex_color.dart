import 'dart:ui';

class AppHexColor {
  static Color hexColor(String color) {
    return Color(int.parse('0xFF$color'));
  }
}
