import 'package:demo711/pages/comment/comment_controller.dart';
import 'package:get/get.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CommentController>(CommentController());
  }
}
