import 'package:tongxinbaike/pages/register/register_controller.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
