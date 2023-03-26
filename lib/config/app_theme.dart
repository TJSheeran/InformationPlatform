import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData themeData = ThemeData(
  primaryColor: AppColor.primary, //主题色
  scaffoldBackgroundColor: AppColor.page, //页面背景色
  indicatorColor: AppColor.bluegreen,
  splashColor: Colors.transparent, //取消水波纹
  highlightColor: Colors.transparent, //取消水波纹
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: AppColor.unactive, // 文字颜色
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.nav,
    elevation: 0,
  ),
  // tabbar的样式
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: AppColor.un2active,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
  ),
  //底部按钮主题
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColor.nav,
    selectedItemColor: AppColor.active,
    unselectedItemColor: AppColor.unactive,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
);
