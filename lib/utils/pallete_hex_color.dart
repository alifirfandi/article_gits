import 'package:flutter/widgets.dart';

class PalleteHexColor {
  static const Color one = Color(0xff5C5D67);
  static const Color two = Color(0xffA68BA5);
  static const Color three = Color(0xffC493B0);
  static const Color four = Color(0xffD199B6);
  static const Color five = Color(0xffEDADC7);

  List<Color> hexColor = [one, two, three, four, five];

  List<Color> listColor() {
    return hexColor;
  }
}
