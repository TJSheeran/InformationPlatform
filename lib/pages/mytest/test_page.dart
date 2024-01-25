import 'package:tongxinbaike/pages/encyclopedia/life_fun/lifefun.dart';
import 'package:tongxinbaike/pages/encyclopedia/life_service/life_service.dart';
import 'package:tongxinbaike/pages/encyclopedia/team/team.dart';
import 'package:tongxinbaike/pages/mytest/test_demo.dart';
import 'package:tongxinbaike/pages/mytest/vertical_tab_bar.dart';
import 'package:flutter/material.dart';
import '../encyclopedia/faculty/faculty.dart';
import '../encyclopedia/food_play/food_play.dart';
import '../encyclopedia/medical/medical.dart';
import '../encyclopedia/transportation/transportation.dart';
import '../encyclopedia/venue/venue.dart';
import 'demo.dart';
import 'head.dart';


class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

const List<Tab> _tabs = [
  Tab(text: '社区服务'),
  Tab(text: '交通出行'),
  Tab(text: '美食'),
  Tab(text: '休闲'),
  Tab(text: '二手'),
  Tab(text: '团购'),
  Tab(text: '组队'),
  // Tab(text: '学院直通'),
];

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      initialIndex: 0, //初始页面下标
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: TabBarView(
            children: [
              // DemoPage(title: "主页"),
              // TestDemoPage(),
              LifeservicePage(),
              TransportationPage(),
              FoodPlayPage(),
              LifeFunPage(),
              VenuePage(),
              //DemoPage(title: '猜你喜欢'),
              MedicalPage(),
              TeamPage(),
              // FacultyPage(),
            ],
            controller: _tabController,
          ),
        ));
  }
}
