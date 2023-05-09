import 'package:tongxinbaike/config/app_theme.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget createApp() {
  return GetMaterialApp(
    initialRoute: Routes.SPLASH,
    getPages: AppPages.pages,
    theme: themeData,
  );
}
