import 'package:flutter/material.dart';
import 'package:get/get.dart';
//必须继承GetxController
class Location extends GetxController {
  //声明的变量后面必须跟.obs.当它变化的时候,使用Obx才能够监听到.
  var latitude = "0".obs;
  var longitude = "0".obs;
  var tabControl = 0.obs;
}