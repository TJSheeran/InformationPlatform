import 'package:tongxinbaike/pages/mine/modifyInfo_controller.dart';
import 'package:get/get.dart';

class ModifyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ModifyInfoController>(ModifyInfoController());
  }
}
