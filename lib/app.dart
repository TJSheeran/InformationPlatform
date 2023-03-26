import 'package:demo711/config/app_theme.dart';
import 'package:demo711/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget createApp() {
  return GetMaterialApp(
    initialRoute: Routes.SPLASH,
    getPages: AppPages.pages,
    theme: themeData,
  );
}
