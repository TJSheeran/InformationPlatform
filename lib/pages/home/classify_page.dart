import 'package:demo711/routes/app_routes.dart';
import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

class ClassifyPage extends StatefulWidget {
  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

Future<List>? flist;
Future<List> _ReadHandle() async {
  var result = await DioUtil().request("/findbaikeFromDemo",
      method: DioMethod.post, data: {"category1": "生活服务", "campus": "嘉定校区"});
  return result;
}

Future<List> _ReadHandle2() async {
  var result = await DioUtil().request("/findbaikeFromDemo",
      method: DioMethod.post, data: {"category1": "场馆活动", "campus": "嘉定校区"});
  return result;
}

List s = [
  '1',
  '2',
  '3',
  'Category1',
  'Category1',
  'Category1',
  'Category1',
  'Category1'
];
Widget HeaderWidget(List s) {
  return ListView.builder(
      itemCount: s.length, //告诉ListView总共有多少个cell
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                s[index]["content"],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 8.0,
                    fontStyle: FontStyle.values[1]),
              ),
              Container(
                height: 20,
              ),
            ],
          ), //每人一辆跑车
        );
      } //使用_cellForRow回调返回每个cell
      );
}

Widget _subHeaderWidget(int groupValue) {
  return Positioned(
    top: 0,
    height: 80,
    width: 200,
    child: Container(
      width: 320,
      height: 50,
      // color: Colors.red,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(
                  "综合" + groupValue.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(
                  "销量" + groupValue.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(
                  "价格" + groupValue.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(
                  "筛选" + groupValue.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _image({required Offset offset, required double angle}) {
  return Transform.translate(
    offset: offset,
    child: Transform.rotate(
      angle: angle,
      child: SvgPicture.asset(
        "assets/icons/background_liquid.svg",
        width: Get.width * .55,
      ),
    ),
  );
}

Widget _bartitle() {
  return Text(
    "  检索分类 ",
    style: Theme.of(Get.context!).textTheme.headline5?.copyWith(
          color: Colors.white,
        ),
  );
}

class _ClassifyPageState extends State<ClassifyPage> {
  @override
  Widget build(BuildContext context) {
    // _getCategory();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Container(
          width: Get.width,
          height: 80,
          color: Colors.blueAccent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _image(
                  offset: Offset(-Get.width * .10, -Get.width * .10),
                  angle: -5),
              _image(
                  offset: Offset(Get.width * .10, Get.width * .10), angle: 4),
            ],
          ),
        ),
        CategoryListNav(),
      ] //CategoryListNav(), //左侧导航
          ),
    );
  }
}

class CategoryListNav extends StatefulWidget {
  @override
  _CategoryListNavState createState() => _CategoryListNavState();
}

class _CategoryListNavState extends State<CategoryListNav> {
  int groupValue = 1;

  List menuList = [
    {
      "title1": "生活服务",
      "title2": "说明",
      "type": 0,
    },
    {"title1": "场馆活动", "title2": "说明", "type": 1},
    {"title1": "菜单三", "title2": "说明", "type": 2},
    {"title1": "菜单四", "title2": "说明", "type": 3},
    {"title1": "菜单五", "title2": "说明", "type": 4},
    {"title1": "菜单六", "title2": "说明", "type": 5},
    {"title1": "菜单七", "title2": "说明", "type": 6},
    {"title1": "菜单八", "title2": "说明", "type": 7},
    {"title1": "菜单九", "title2": "说明", "type": 8},
    {"title1": "菜单十", "title2": "说明", "type": 9},
  ];

  @override
  void initState() {
    super.initState();
    flist = _ReadHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: floatButton,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: FutureBuilder(
          future: flist,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Stack(children: [
              Container(
                width: Get.width,
                height: 80,
                color: Colors.blueAccent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _image(
                        offset: Offset(-Get.width * .10, -Get.width * .10),
                        angle: -5),
                    _image(
                        offset: Offset(Get.width * .10, Get.width * .10),
                        angle: 4),
                  ],
                ),
              ),
              CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  //height: 120.0,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(
                                      top: 20.0,
                                      left: 0.0,
                                      bottom: 0.0), //容器外填充//容器内填充
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          _bartitle(),
                                          SizedBox(height: 23),
                                          menuListItem(context, menuList[0]),
                                          menuListItem(context, menuList[1]),
                                          menuListItem(context, menuList[2]),
                                          menuListItem(context, menuList[3]),
                                          menuListItem(context, menuList[4]),
                                          menuListItem(context, menuList[5]),
                                          menuListItem(context, menuList[6]),
                                          //menuListItem(context,menuList[7]),
                                        ],
                                      ),
                                      Column(children: <Widget>[
                                        //_subHeaderWidget(groupValue),
                                        if (snapshot.hasData)
                                          SizedBox(
                                              height: 520,
                                              width: 300,
                                              child:
                                                  HeaderWidget(snapshot.data)),
                                      ])
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  )
                ],
              )
            ]);
          }),

//                     CustomScrollView(
//                       slivers: <Widget>[
//                         SliverPadding(
//                           padding: const EdgeInsets.all(0.0),
//                           sliver:  SliverList(
//                             delegate:  SliverChildListDelegate(
//                               <Widget>[
//                                 Container(
//                                   child: Column(
//                                     children: <Widget>[
//                                       Container(
//                                         //height: 120.0,
//                                         width: double.maxFinite,
//                                         margin: EdgeInsets.only(top: 20.0,
//                                             left: 0.0,
//                                             bottom: 0.0), //容器外填充//容器内填充
//                                         child: Row(
//                                           children: <Widget>[
//                                             Column(
//                                               children: <Widget>[
//                                                 SizedBox(height: 10),
//                                                 _bartitle(),
//                                                 SizedBox(height: 23),
//                                                 menuListItem(context,menuList[0]),
//                                                 menuListItem(context,menuList[1]),
//                                                 menuListItem(context,menuList[2]),
//                                                 menuListItem(context,menuList[3]),
//                                                 menuListItem(context,menuList[4]),
//                                                 menuListItem(context,menuList[5]),
//                                                 menuListItem(context,menuList[6]),
//                                                 //menuListItem(context,menuList[7]),
//                                               ],
//                                             ),
//                                             Column(
//                                               children: <Widget>[
//                                                 _subHeaderWidget(groupValue),
//                                                 if(snapshot.hasData)
//                                                    SizedBox(
//                                                      height: 520,
//                                                      width: 300,
//                                                      child:
//                                                           HeaderWidget(snapshot.data)
//                                                    ),
//
//
//               ]
//                                             )
//                                                 ],
//                                               ),
//                                             )
//
//                                           ],
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                                     )
//                             ],
//                           )]
//                         );}
//         ),
//                     );}
//
//   Widget menuListItem(context,value) {
//     // print(value['type']);
//     return groupValue==value['type'] ?
//     Container(
//       height: 77.0,
//       width: 80,
//       child: TextButton(
//           onPressed: () {
//             updateGroupValue(value['type']);
//           },
//           child:Text.rich(TextSpan(
//               children: [
//                 TextSpan(
//                   text: value['title1'],
//                   style: TextStyle(
//                     color: Color(0xFFFA3F3F),
//                     fontSize: 14,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "\n"+value['title2'],
//                   style: TextStyle(
//                     color: Color(0xFF999999),
//                     fontSize: 12,
//                   ),
//                 ),
//               ]
//           ))
//         /*Text(value['title1'],style: TextStyle(color: Colors.red),),*/
//       ),
//     )
//         :
//     Container(
//       height: 77.0,
//       width: 80,
//       child: TextButton(
//           onPressed: (){
//             updateGroupValue(value['type']);
//             value['title1']=="场馆活动"?flist=_ReadHandle2():flist=_ReadHandle();
//             setState(() {});
//           },
//           child:Text.rich(TextSpan(
//               children: [
//                 TextSpan(
//                   text: value['title1'],
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "\n"+value['title2'],
//                   style: TextStyle(
//                     color: Color(0xFF999999),
//                     fontSize: 12,
//                   ),
//                 ),
//               ]
//           ))
//         /*Text(value['title1'],style: TextStyle(color: Colors.red),),*/
//       ),
// >>>>>>> Stashed changes
    );
  }

  Widget menuListItem(context, value) {
    // print(value['type']);
    return groupValue == value['type']
        ? Container(
            height: 77.0,
            width: 80,
            child: TextButton(
                onPressed: () {
                  updateGroupValue(value['type']);
                },
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: value['title1'],
                    style: TextStyle(
                      color: Color(0xFFFA3F3F),
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "\n" + value['title2'],
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                    ),
                  ),
                ]))
                /*Text(value['title1'],style: TextStyle(color: Colors.red),),*/
                ),
          )
        : Container(
            height: 77.0,
            width: 80,
            child: TextButton(
                onPressed: () {
                  updateGroupValue(value['type']);
                  value['title1'] == "场馆活动"
                      ? flist = _ReadHandle2()
                      : flist = _ReadHandle();
                  setState(() {});
                },
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: value['title1'],
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "\n" + value['title2'],
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                    ),
                  ),
                ]))
                /*Text(value['title1'],style: TextStyle(color: Colors.red),),*/
                ),
          );
  }

  void updateGroupValue(int v) {
    setState(() {
      groupValue = v;
    });
  }
}
