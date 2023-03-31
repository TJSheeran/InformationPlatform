import 'package:flutter/material.dart';
import 'custom_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
class HomeButtons extends StatelessWidget {
  HomeButtons({Key? key}) : super(key: key);

  final List<CustomIconButton> _listButton = [
    CustomIconButton(
      icon: FontAwesomeIcons.skiing,
      label: "运动",
      onPressed: () {Get.toNamed(Routes.TEST);},
      primary: Colors.green[300],
    ),
    CustomIconButton(
      icon: FontAwesomeIcons.chess,
      label: "聚会",
      onPressed: () {Get.toNamed(Routes.TEST);},
      primary: Colors.blue,
    ),
    CustomIconButton(
      icon: FontAwesomeIcons.meteor,
      label: "娱乐",
      onPressed: () {Get.toNamed(Routes.TEST);},
      primary: Colors.redAccent,
    ),
    CustomIconButton(
      icon: FontAwesomeIcons.guitar,
      label: "音乐",
      onPressed: () {Get.toNamed(Routes.TEST);},
      primary: Colors.brown[400],
    ),
    CustomIconButton(
      icon: FontAwesomeIcons.car,
      label: "出行",
      onPressed: () {Get.toNamed(Routes.TEST);},
      primary: Colors.blue,
    ),
    CustomIconButton(
      icon: Icons.more_horiz,
      label: "更多",
      onPressed: () {Get.toNamed(Routes.TEST);},
      primary: Colors.indigoAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: _listButton.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 10 : 0,
              right: 10,
            ),
            child: _listButton[index],
          );
        },
      ),
    );
  }
}
