import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../config/app_colors.dart';
import '../../view/root_pages/message_page.dart';
import '../../view/root_pages/niceplay_page.dart';
import '../home/home_page.dart';
import '../mine/mine_page.dart';
import '../mytest/test_page.dart';
import '../publish/publish_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

const Map<String, String> _bottomNames = {
  'home': '首页',
  'niceplay': '发现',
  'create_media': '',
  'message': '消息',
  'mine': '我的',
};

class _RootPageState extends State<RootPage> {
  //当前选中页索引
  int _currentIndex = 0;

  //页面集合
  final List<Widget> _pages = [
    TestPage(),
    NiceplayPage(),
    Container(),
    MessagePage(),
    MinePage(),
  ];

  //底部导航数组
  final List<BottomNavigationBarItem> _bottomNavigationBarList = [];

  @override
  void initState() {
    super.initState();
    //生成底部导航
    _bottomNames.forEach((key, value) {
      _bottomNavigationBarList.add(_bottomNavigationBarItem(key, value));
    });
  }

  //底部切换
  void _onTabClick(int index) {
    if (index == 2) {
      return _onCreateMedia();
    }

    setState(() {
      _currentIndex = index;
    });
  }

  //点击发布按钮
  void _onCreateMedia() {
    // print('发布活动');
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => PublishPage(),
    //     ),
    //     (route) => false);

    showBarModalBottomSheet(
        context: context,
        builder: (context) => PublishPage(),
        enableDrag: true,
        expand: true,
        duration: const Duration(milliseconds: 400),
        backgroundColor: Colors.transparent);

    // showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true,
    //     builder: (context) {
    //       return Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           FlutterLogo(
    //             size: 64,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(24),
    //             child: Text(
    //               '这是一大段测试文字，就问你看到了怕不怕',
    //               style: TextStyle(fontSize: 22),
    //             ),
    //           ),
    //           Container(
    //             height: MediaQuery.of(context).size.height * 0.7,
    //             child: ListView.builder(
    //               itemCount: 200,
    //               itemBuilder: (context, index) => Container(
    //                 height: 48,
    //                 color: Colors.cyan[(index % 9 + 1) * 100],
    //               ),
    //             ),
    //           )
    //         ],
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _creatMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //发布按钮
  Widget _creatMediaButton() {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.only(top: 45),
      child: FloatingActionButton(
        heroTag: "btnsecond",
        backgroundColor: AppColor.nav,
        child: Image.asset(
          // 'assets/icons/tabbar_post_idle@2x.png',
          'assets/icons/create_media.png',
        ),
        onPressed: _onCreateMedia,
        elevation: 0, //未点击时的阴影
        highlightElevation: 0, //点击时的阴影
      ),
    );
  }

  //底部导航每一项的组件
  BottomNavigationBarItem _bottomNavigationBarItem(String key, String value) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/icons/$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        'assets/icons/${key}_active.png',
        width: 24,
        height: 24,
      ),
      label: value,
    );
  }
}
