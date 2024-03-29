// import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/models/illustration.dart';
import 'package:tongxinbaike/pages/splash/splash_controller.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.googleblack,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 5),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/icons/background_liquid.svg",
                        width: Get.width * .7,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/phone-3d.png",
                        width: Get.width * .8,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      "社区校园生活信息一网打尽",
                      textAlign: TextAlign.center,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .headline5!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 2,
                              wordSpacing: 1.8,
                              letterSpacing: 1.3),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "一切都触手可及",
                      style: TextStyle(color: Colors.grey[200], fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Spacer(flex: 3),
                MaterialButton(
                    minWidth: 300.0,
                    height: 50.0,
                    shape: const StadiumBorder(),
                    color: AppColor.bluegreen,
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "现 在 开 始",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                Spacer(flex: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
