///帖子显示页
///使用FutureBuilder完成异步收发与显示
///目前可能与底端UI适配还存在一定问题
///还没写上拉刷新，目前还是刷新按钮
///已经实现了CustomScrollView的滑动拖取和接收帖子显示
///刚刚Debug解决了不同帖子的显示出界问题
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:flutter/material.dart';
//import 'package:tongxinbaike/utils/dio_http.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/view/card/pet_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tongxinbaike/config/app_colors.dart';

class CommPage extends StatefulWidget {
  static String tag = 'comm-page';
  const CommPage({Key? key}) : super(key: key);
  @override
  _CommPageState createState() => _CommPageState();
}

// Textmaker(News textcon) {
//   final titext = Text(
//     textcon.text!,
//     textAlign: TextAlign.center,
//   );
//   return titext;
// }

class _CommPageState extends State<CommPage> {
  Future<List<News>>? _news;
  Future<List<News>> _ReadHandle() async {
    //const url = 'https://reqres.in/api/cupcakes';
    //const url = 'https://tongxinshequ.cn/tuijian';
    // const url ='https://tongxinshequ.cn/test';
    // var params ={
    //   'uid':'1'
    // };
    var result = await DioUtil().request(
      "/test",
      method: DioMethod.post,
      data: {'uid': '1'},
    );
    //print(result);
    List<News> act = convertNews(result);
    return act;
    // var res = await DioHttp.of(context).post(url,params);
    // print(res.toString());

    // if(jsonDecode(res.toString())['list'] == null)
    //   print("not catch!");
    // else
    //  { List listuser = jsonDecode(res.toString())['list'];
    //    //print(listuser[2]['text']);
    //   return listuser;}
  }

  @override
  void initState() {
    super.initState();
    _news = _ReadHandle();
  }

  // List _listuser=[];
  // void initState() {
  //   _ReadHandle().then((data) => setState(() {
  //     _listuser = data;
  //   }));
  //   super.initState();
  // }
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    _news = _ReadHandle();
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    //_refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // final floatButton = FloatingActionButton(
    //     ///点击响应事
    //   onPressed: () async{
    //     await _ReadHandle();
    //     },
    //     ///长按提示
    //   tooltip: "刷新页面",
    //     ///设置悬浮按钮的背景
    //   backgroundColor: Colors.purpleAccent,
    //     ///获取焦点时显示的颜色
    //   focusColor: Colors.green,
    //     ///鼠标悬浮在按钮上时显示的颜色
    //   hoverColor: Colors.yellow,
    //     ///水波纹颜色
    //   splashColor: Colors.deepPurple,
    //     ///定义前景色 主要影响文字的颜色
    //   foregroundColor: Colors.black,
    //     ///配制阴影高度 未点击时
    //   elevation: 0.0,
    //     ///配制阴影高度 点击时
    //   highlightElevation: 20.0,

    //   child: const Text('刷新',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),

    // );

    //initState();
    return Scaffold(
        // floatingActionButton: floatButton,
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: FutureBuilder(
            future: _news,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: AppColor.purple,
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: CustomScrollView(
                      slivers: <Widget>[
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
                                      arguments: snapshot.data[
                                          snapshot.data.length - index - 1]);
                                },
                                child: TabCard(
                                    data: snapshot.data[
                                        snapshot.data.length - index - 1]),
                              );
                            }),
                          ),
                        ),
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(left: 210),
                    child: CircularProgressIndicator(
                      strokeWidth: 8.0,
                      color: AppColor.purple,
                    ));
              }
            }));
  }
}


      // backgroundColor: Colors.white,
      // floatingActionButton: floatButton,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // body: Center(
      //   child: Center(
      //     child: ListView(
      //       shrinkWrap: true,
      //       //padding: const EdgeInsets.only(left: 24.0,right: 24.0),
      //       children: <Widget>[
      //         //Textmaker(listuser[1]['text']),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             fronttext,
      //             register,
      //           ],
      //         ),
      //         const SizedBox(height: 180.0,)
      //       ],
      //     ),
      //   ),
      // ),
//     );
//   }
// }