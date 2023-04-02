// GetX一个页面的标准文件分布：page / controller（生命周期） / binding（把controller注入整个项目中）

import 'package:tongxinbaike/common/common_config.dart';
import 'package:tongxinbaike/models/illustration.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //通过 illustrations 数组来控制页面显示的img到底有几张
  List<Illustration> illustrations = List.from(splashIllustrations);

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
