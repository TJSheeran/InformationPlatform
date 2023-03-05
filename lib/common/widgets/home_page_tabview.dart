import 'package:demo711/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePageTabView extends StatefulWidget {
  final List<String>? tabIcons;
  final Color? activeColor;
  final Color? bgColor;
  //向上方视图传递index点击状态
  final Function(int index)? onPress;
  int selectedIndex;

  HomePageTabView({
    Key? key,
    @required this.tabIcons,
    this.activeColor = AppColor.purple,
    this.bgColor = AppColor.nav,
    this.onPress,
    this.selectedIndex = 0,
  })  : assert(tabIcons!.length <= 5),
        assert(selectedIndex <= tabIcons!.length - 1),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageTabViewState();
  }
}

class HomePageTabViewState extends State<HomePageTabView> {
  //按钮数组
  List<Widget> _renderTabButton() {
    return widget.tabIcons!.asMap().keys.map((index) {
      String asset = widget.tabIcons![index];

      return Container(
        width: Get.width / widget.tabIcons!.length,
        height: double.infinity,
        child: IconButton(
          icon: SvgPicture.asset(
            asset,
            color: index == widget.selectedIndex
                ? widget.activeColor
                : AppColor.un3active,
          ),
          onPressed: () {},
        ),
      );
    }).toList();
  }

  @override
  Widget build(Object context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _renderTabButton(),
      ),
    );
  }
}
