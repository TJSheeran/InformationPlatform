import 'package:demo711/pages/home/detail_controller.dart';
import 'package:get/get.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailController>(DetailController());
  }
}
