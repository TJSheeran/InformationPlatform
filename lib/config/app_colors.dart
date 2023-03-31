import 'package:flutter/cupertino.dart';

// 颜色配置
class AppColor {
  static const Color primary = Color(0xfffbfbfb);

  static const Color success = Color(0xff07c160);

  static const Color danger = Color(0xffee0a24);

  static const Color warning = Color(0xffffba00);

  static const Color info = Color(0xff00a1d6);

  static const Color active = Color(0xff464646);

  static const Color unactive = Color(0xff7b7b7b);

  static const Color un2active = Color(0xff8d8d8d);

  static const Color un3active = Color(0xffb1b1b1);

  static const Color page = Color(0xfff7f7f7);

  static const Color nav = Color.fromRGBO(255, 255, 255, 1);

  static const Color border = Color(0xfff5f5f5);

  static const Color purple = Color.fromRGBO(162, 76, 212, 1);
  // 162, 76, 212, 1
  // 136, 129, 251, 1

  static const Color green = Color.fromRGBO(195, 221, 83, 1);

  static const Color clean = Color(0xffffffff);

  static const Color grey = Color.fromARGB(235, 231, 231, 231);

  static const Color bluegreen = Color.fromRGBO(134, 213, 203, 1);

  static const Color red1 = Color.fromRGBO(248, 135, 118, 1);

  static const Color red2 = Color.fromRGBO(248, 135, 148, 1);

  static const Color red3 = Color.fromRGBO(248, 136, 173, 1);

  static const Color yellow = Color.fromRGBO(251, 195, 46, 1);

  static const Color shallowred = Color.fromRGBO(247, 240, 245, 1);

  static const Color shallowblue = Color.fromRGBO(239, 244, 248, 1);

  static const Color shallowgreen = Color.fromRGBO(246, 247, 239, 1);

  static const Color googleblack = Color.fromRGBO(47, 47, 47, 1); //53, 54, 58

  static const Color vuegreen = Color.fromRGBO(112, 208, 151, 1);

  // 颜色值转换
  static Color string2Color(String colorString) {
    int value = 0x00000000;
    if (colorString.isNotEmpty) {
      if (colorString[0] == '#') {
        colorString = colorString.substring(1);
      }
      value = int.tryParse(colorString, radix: 16)!;
      if (value != null) {
        if (value < 0xFF000000) {
          value += 0xFF000000;
        }
      }
    }
    return Color(value);
  }
}
