// import 'package:demo711/models/illustration.dart';

import '../models/illustration.dart';

final List splashIllustrations = [
  //'assets/icons/create_media.png',
  Illustration(
      asset: 'assets/icons/splash1.jpg', copyright: 'Designed by Lin Lab'),
  Illustration(
      asset: 'assets/icons/splash2.png', copyright: 'https://tongxinshequ.cn'),
];

final List<int> defaultTargetPersonNumber = [2, 3, 5, 10, 15, 20];

final List<String> defaultFirstLevel = [
  "生活服务",
  "交通出行",
  "场馆服务",
  "美食休闲",
  "医 疗",
  "学院直通"
];

//defaultTargetLabels

final List<String> defaultSecondLevel = ["快递", "空调", "电费", "医保", "寝室"];
