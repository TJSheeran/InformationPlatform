import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var pageController = PageController();

  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  //getx 页面初始化 onInit()
  void onInit() {
    //调用基类的 onInit()
    super.onInit();
  }

  @override
  //getx 在page文件中的build绘制好视图之后会调用 onReady()函数
  void onReady() {
    //调用基类的 onReady()
    super.onReady();
  }
}
