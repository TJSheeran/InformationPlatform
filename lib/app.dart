import 'package:sp_util/sp_util.dart';
import 'package:tongxinbaike/config/app_theme.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/initialBlinds.dart';

Widget createApp() {
  return GetMaterialApp(
    initialRoute: SpUtil.haveKey("userToken")!=true?Routes.SPLASH:Routes.ROOT,
    initialBinding: InitialBlinds(),
    getPages: AppPages.pages,
    theme: themeData,
  );
}
