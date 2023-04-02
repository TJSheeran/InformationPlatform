import 'package:tongxinbaike/models/illustration.dart';

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

// final List<String> defaultSecondLevel = ["快递", "空调", "电费", "医保", "寝室"];

final levelMap = <String, List<String>>{
  "生活服务": ["快递", "空调", "电费", "医保", "寝室", "差旅报销"],
  "交通出行": ["短驳车", "定班车", "北安跨线", "地铁出行", "交通枢纽", "火车票"],
  "场馆服务": ["篮球", "羽毛球", "田径场", "游泳馆", "场地借用"],
  "美食休闲": ["商圈", "电影院", "美食", "超市"],
  "医 疗": ["医院", "药店", "报销流程", "校医院"],
  "学院直通": ["电信学院", "经管学院", "艺传学院", "材料学院", "交运学院", "机械学院"]
};
