import 'package:demo711/config/app_colors.dart';
import 'package:demo711/view/home_pages/comm.dart';
import 'package:flutter/material.dart';
import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/news.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:demo711/view/card/pet_card.dart';
import 'package:get/get.dart';
import 'package:demo711/routes/app_routes.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  Future<List<News>> _ReadHandle() async {
    var result = await DioUtil().request(
      "/personal",
      method: DioMethod.post,
      data: {'uid': '1'},
    );
    List<News> act = convertNews(result);
    return act;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _ReadHandle(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.pinkAccent,
                                    AppColor.purple
                                  ])),
                              child: Container(
                                width: double.infinity,
                                height: 300.0,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 35.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg",
                                        ),
                                        radius: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Sheeran",
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.page,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Card(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        //shape 设置边，可以设置圆角
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),

                                        clipBehavior: Clip.antiAlias,
                                        color: Colors.white,
                                        elevation: 5.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0, vertical: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "发布活动",
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      "36",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            Colors.pinkAccent,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "粉丝",
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      "28.6K",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            Colors.pinkAccent,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "关注",
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      "1200",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            Colors.pinkAccent,
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
                                  ),
                                ),
                              )),
                          // Container(
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: <Widget>[
                          //         Text(
                          //           "Bio:",
                          //           style: TextStyle(
                          //               color: Colors.redAccent,
                          //               fontStyle: FontStyle.normal,
                          //               fontSize: 28.0),
                          //         ),
                          //         SizedBox(
                          //           height: 10.0,
                          //         ),
                          //         Text(
                          //           'My name is Alice and I am  a freelance mobile app developper.\n'
                          //           'if you need any mobile app for your company then contact me for more informations',
                          //           style: TextStyle(
                          //             fontSize: 22.0,
                          //             fontStyle: FontStyle.italic,
                          //             fontWeight: FontWeight.w300,
                          //             color: Colors.black,
                          //             letterSpacing: 2.0,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: 5.0,
                          ),
                          // Container(
                          //   width: 300.00,
                          //   // flex: 2,
                          //   child: TextButton(
                          //       onPressed: () {},
                          //       // shape: RoundedRectangleBorder(
                          //       //   borderRadius: BorderRadius.circular(80.0)
                          //       // ),
                          //       // elevation: 0.0,
                          //       //   padding: EdgeInsets.all(0.0),
                          //       child: Ink(
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //               begin: Alignment.centerRight,
                          //               end: Alignment.centerLeft,
                          //               colors: [AppColor.purple, Colors.pinkAccent]),
                          //           borderRadius: BorderRadius.circular(30.0),
                          //         ),
                          //         child: Container(
                          //           constraints:
                          //               BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          //           alignment: Alignment.center,
                          //           child: Text(
                          //             "Contact me",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 26.0,
                          //                 fontWeight: FontWeight.w300),
                          //           ),
                          //         ),
                          //       )),
                          // ),
                        ],
                      ),
                    ])),

                    //floatButton,
                    SliverList(
                      delegate: SliverChildListDelegate(
                        //返回组件集合
                        List.generate(snapshot.data.length, (int index) {
                          //返回 组件
                          return GestureDetector(
                            onTap: () {
                              // News_print(snapshot.data[snapshot.data.length-index-1]);
                              Get.toNamed(Routes.DETAIL,
                                  arguments: snapshot
                                      .data[snapshot.data.length - index - 1]);
                            },
                            child: TabCard(
                                data: snapshot
                                    .data[snapshot.data.length - index - 1]),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(left: 100),
                    child: CircularProgressIndicator(
                      strokeWidth: 8.0,
                      color: AppColor.purple,
                    ));
              }
            }));
  }
}
