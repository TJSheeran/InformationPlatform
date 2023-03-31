//binding 文件是为了把 controller 文件注入整体项目，和 page 产生联系
import 'package:tongxinbaike/pages/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
