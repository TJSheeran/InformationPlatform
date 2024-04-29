import 'package:flutter_floating/floating/assist/floating_slide_type.dart';
import 'package:flutter_floating/floating/floating.dart';
import 'package:flutter_floating/floating_increment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/pages/encyclopedia/life_fun/lifefun.dart';
import 'package:tongxinbaike/pages/encyclopedia/life_service/life_service.dart';
import 'package:tongxinbaike/pages/encyclopedia/team/team.dart';
import 'package:tongxinbaike/pages/mytest/test_demo.dart';
import 'package:tongxinbaike/pages/mytest/vertical_tab_bar.dart';
import 'package:flutter/material.dart';
import '../../dio_util/dio_method.dart';
import '../../dio_util/dio_util.dart';
import '../encyclopedia/faculty/faculty.dart';
import '../encyclopedia/food_play/food_play.dart';
import '../encyclopedia/medical/medical.dart';
import '../encyclopedia/transportation/transportation.dart';
import '../encyclopedia/venue/venue.dart';
import '../login/login_page.dart';
import '../publish/publish2_page.dart';
import 'demo.dart';
import 'head.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';


class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);
  @override
  State<TestPage> createState() => _TestPageState();
}

const List<Tab> _tabs = [
  Tab(text: '吐槽专区'),
  Tab(text: '社区服务'),
  Tab(text: '美食'),
  Tab(text: '休闲'),
  Tab(text: '二手'),
  Tab(text: '团购'),
  Tab(text: '组队'),
  Tab(text: '交通出行'),
  // Tab(text: '学院直通'),
];

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  late TabController _tabController;
  // late Floating floating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // floating = Floating(const FloatingIncrement(),
    //     slideType: FloatingSlideType.onLeftAndTop,
    //     isShowLog: false,
    //     slideBottomHeight: 100);
    // floating.open(context);
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
  TextEditingController contentController = TextEditingController()
    ..addListener(() {});

  FocusNode contentFocusNode = FocusNode();

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: Color.fromRGBO(240, 240, 240, 1),
    ),
  );

  imageUpload(String contenttext) async {
    var result =
    await DioUtil().request("/advice/postAdvice", method: DioMethod.post, data: {
      'content': contenttext,
      'uid': uid,
    });
    Fluttertoast.showToast(
        msg: result['info'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void onCreateMedia() {
    showBarModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
      return Container(
          height: 350,
          color: Colors.transparent,
          child: Scaffold(
              backgroundColor: AppColor.page,
              body: SafeArea(
                  child: GestureDetector(
                      onTap: () {
                        //隐藏键盘
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: Container(
                        // color: CupertinoTheme.of(context)
                        //     .scaffoldBackgroundColor
                        //     .withOpacity(0.1),
                        // color: Colors.white.withOpacity(0.1),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                      height: 60,
                                      color: Colors.transparent,
                                      child: Stack(children: [
                                        Positioned(
                                            top: 20,
                                            left: 20,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('取消'.tr,
                                                  style: TextStyle(
                                                      color: AppColor.bluegreen,
                                                      fontSize: 18)),
                                            )),
                                        Positioned(
                                            top: 20,
                                            right: 20,
                                            child: InkWell(
                                              onTap: () {
                                                // print('发布活动');
                                                DateTime now = DateTime.now();
                                                String nowtimestamp =
                                                    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

                                                if (nowtimestamp != '' &&
                                                    contentController.text !=
                                                        '') {
                                                  Navigator.of(context).pop();
                                                  imageUpload(contentController.text);
                                                } else if (
                                                contentController.text ==
                                                    '') {
                                                  Fluttertoast.showToast(
                                                      msg: "内容不能为空！",
                                                      toastLength:
                                                      Toast.LENGTH_LONG,
                                                      gravity:
                                                      ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor:
                                                      Colors.black45,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(5)),
                                                    color: AppColor.bluegreen),
                                                width: 60,
                                                height: 30,
                                                alignment: Alignment.center,
                                                child: Text('发送'.tr,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18)),
                                              ),
                                            ))
                                      ]))),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 50,
                                  bottom: 0,
                                  child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(bottom: 40),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    padding: EdgeInsets.only(
                                                        left: 0.0, right: 0),
                                                    // color: Colors.orange,
                                                    // decoration: BoxDecoration(
                                                    //     color:
                                                    //         Color.fromRGBO(240, 240, 240, 1),
                                                    //     borderRadius: BorderRadius.all(
                                                    //         Radius.circular(26.0))),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets.only(
                                                              left: 10,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                            )),
                                                        Container(
                                                            margin: EdgeInsets.only(
                                                              left: 10,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Container(
                                                                    height: 60,
                                                                    // color: Colors.orange,
                                                                    alignment: Alignment
                                                                        .center,
                                                                    child: Text(
                                                                        '意见反馈'.tr,
                                                                        style:
                                                                        TextStyle(
                                                                          color: AppColor
                                                                              .active,
                                                                          fontSize:
                                                                          18.0,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                        ))),
                                                              ],
                                                            )),
                                                        Container(
                                                          width: 600,
                                                          height: 145,
                                                          margin: EdgeInsets.only(
                                                              left: 20),
                                                          decoration: BoxDecoration(
                                                              color: Color.fromRGBO(
                                                                  240, 240, 240, 1),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      5.0))),
                                                          alignment:
                                                          Alignment.topLeft,
                                                          child: TextField(
                                                            controller:
                                                            contentController,
                                                            focusNode:
                                                            contentFocusNode,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: AppColor.active,
                                                            ),
                                                            maxLines: 6,
                                                            minLines: 1,
                                                            onChanged: (text) {
                                                              setState(() {});
                                                            },
                                                            decoration:
                                                            InputDecoration(
                                                              fillColor:
                                                              Color.fromRGBO(240,
                                                                  240, 240, 1),
                                                              filled: true,
                                                              isCollapsed: true,
                                                              contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  10,
                                                                  vertical:
                                                                  8),
                                                              border:
                                                              _outlineInputBorder,
                                                              focusedBorder:
                                                              _outlineInputBorder,
                                                              enabledBorder:
                                                              _outlineInputBorder,
                                                              disabledBorder:
                                                              _outlineInputBorder,
                                                              focusedErrorBorder:
                                                              _outlineInputBorder,
                                                              errorBorder:
                                                              _outlineInputBorder,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )))
                            ],
                          ))))));},
        enableDrag: true,
        duration: const Duration(milliseconds: 400),
        backgroundColor: Colors.transparent);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    // floating.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WDScreenButton.initConfig(
    //   GlobalKey(),
    //   left: 30,
    //   top: 100,
    //   isShowBtn: true,
    //   buttonChild: Icon(Icons.add, size: 36, color: Colors.white),
    //   callBack: () {
    //     // 点击按钮触发的操作
    //   },
    // );
    //floating.open(context);
    return
        Scaffold(
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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.announcement,color: Colors.black,size: 40,),
            onPressed: ()  {
              onCreateMedia();
            },
            backgroundColor: AppColor.bluegreen
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: TabBarView(
            children: [
              // DemoPage(title: "主页"),
              // TestDemoPage(),
              FacultyPage(),
              LifeservicePage(),
              FoodPlayPage(),
              LifeFunPage(),
              VenuePage(),
              //DemoPage(title: '猜你喜欢'),
              MedicalPage(),
              TeamPage(),
              TransportationPage(),
            ],
            controller: _tabController,
          ),
        ));
  }
}
