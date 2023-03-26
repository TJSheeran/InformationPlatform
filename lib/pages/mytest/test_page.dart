import 'package:demo711/pages/mytest/test_demo.dart';
import 'package:demo711/pages/mytest/vertical_tab_bar.dart';
import 'package:flutter/material.dart';
import 'demo.dart';
import 'head.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

const List<Tab> _tabs = [
  Tab(text: '生活服务'),
  Tab(text: '交通出行'),
  Tab(text: '场馆服务'),
  Tab(text: '美食休闲'),
  Tab(text: '医疗'),
  Tab(text: '学院直通'),
];

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
      initialIndex: 2, //初始页面下标
      length: _tabs.length, //tabbar有几个就写成几
      vsync: this,
    );

    // 监听切换
    _tabController.addListener(() {
      _tabController.index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RootPageHead(),
        // title: VerticalTabBar(),
        //隐藏返回按钮
        automaticallyImplyLeading: false,
        // backgroundColor: AppColor.purple,
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          indicatorWeight: 3.0,
          isScrollable: true,
          // labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: TabBarView(
        children: [
          // DemoPage(title: "主页"),
          // TestDemoPage(),
          VerticalTabBar(),
          DemoPage(title: '推荐'),
          DemoPage(title: '猜你喜欢'),
          DemoPage(title: '上海'),
          DemoPage(title: '校园'),
          DemoPage(title: '附近'),
        ],
        controller: _tabController,
      ),
    );
  }
}
