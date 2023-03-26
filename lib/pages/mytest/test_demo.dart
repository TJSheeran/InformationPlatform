import 'package:demo711/pages/mytest/vertical_tab_bar.dart';
import 'package:flutter/material.dart';

class TestDemoPage extends StatelessWidget {
  const TestDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: VerticalTabBar(),
        // title: VerticalTabBar(),
        //隐藏返回按钮
        automaticallyImplyLeading: false,
        // backgroundColor: AppColor.purple,
      ),
      body: Text("happy"),
    );
  }
}
