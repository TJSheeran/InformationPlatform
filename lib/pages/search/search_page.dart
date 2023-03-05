///帖子显示页
///使用FutureBuilder完成异步收发与显示
///目前可能与底端UI适配还存在一定问题
///还没写上拉刷新，目前还是刷新按钮
///已经实现了CustomScrollView的滑动拖取和接收帖子显示
///刚刚Debug解决了不同帖子的显示出界问题
import 'package:demo711/routes/app_routes.dart';
import 'package:flutter/material.dart';
//import 'package:demo711/utils/dio_http.dart';
import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/news.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:demo711/view/card/pet_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:demo711/config/app_colors.dart';

class SearchPage extends StatefulWidget {
  static String tag = 'Searchpage';
  SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

// Textmaker(News textcon) {
//   final titext = Text(
//     textcon.text!,
//     textAlign: TextAlign.center,
//   );
//   return titext;
// }

class _SearchPageState extends State<SearchPage> {
  Future<List<News>>?_news;
  Future<List<News>> _ReadHandle() async {
    var content = Get.arguments;
    var result = await DioUtil().request(
      "/test",
      method: DioMethod.post,
      data: {'uid': '1'},
    );
    print(content);
    List<News> act = convertNews(result);
    return act;

  }
  @override
  void initState(){
    super.initState();
    _news=_ReadHandle();
  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    _news=_ReadHandle();
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


