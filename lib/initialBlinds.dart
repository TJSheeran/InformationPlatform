import 'package:get/get.dart';
import 'package:tongxinbaike/gexControl/location.dart';
import 'package:tongxinbaike/gexControl/userController.dart';
class InitialBlinds extends Bindings { // 1
  @override
  void dependencies() {
    Get.lazyPut(()=>Location()); // 2
    Get.lazyPut(()=>UserController());
  }
}
