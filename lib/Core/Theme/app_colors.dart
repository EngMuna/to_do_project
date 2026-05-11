import 'package:flutter/material.dart';

class AppColors {
  static Color _colorFromHex(String hexColor) {
    final color = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$color', radix: 16));
  }

  static Color _colorOpacity20FromHex(String hexColor) {
    final color = hexColor.replaceAll('#', '');
    return Color(int.parse('33$color', radix: 16));
  }

  static Color veryLightPinkBackground = const Color.fromARGB(
    255,
    227,
    218,
    226,
  );
  static Color lightPinkBackground = const Color.fromARGB(255, 190, 130, 195);

  static Color mainColor = _colorFromHex('#6A11CB');
  static Color main1Color = _colorFromHex('#5F4929');
  static Color secondaryColor = _colorFromHex('#BE9B37');
  static Color blackColor = _colorFromHex('#000000');
  static Color blue = _colorFromHex('#00ABD5');
  static Color borderColor = _colorFromHex('#ADADAD');
  static Color hintColor = _colorFromHex('#BABABA');
  static Color darkGrey = _colorFromHex('#959595');
  static Color white = _colorFromHex('#FFFFFF');
  static Color formFillColor = _colorOpacity20FromHex('#FFFFFF');
  static Color errorColor = _colorFromHex('#D70404');
  static Color green = _colorFromHex('#5ABD8C');
  static Color lightGreen = _colorFromHex('#00AA08');
  static Color borderGrey = _colorFromHex('#CAC8C8');
  static Color red = _colorFromHex('#FF270E');
  static Color lightGrey = _colorFromHex('#8F8E8F');
  static Color lightyellow = _colorFromHex('#FFF3D8');
}
