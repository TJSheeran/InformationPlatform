import 'package:demo711/pages/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
