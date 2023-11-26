import 'package:flutter/material.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'message_card.dart';
import 'Mes.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import '../../dio_util/dio_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tongxinbaike/pages/login/login_page.dart';
class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<List<Mes>> _ReadHandle() async {
    var result = await DioUtil().request(
      "/comment/"+uid.toString(),
      method: DioMethod.get,
      //data: {'uid': '1'},
    );
    List<Mes> act = convertMes(result);
    // List<Mes> act=[];
    // act.add(Mes("用户名","回复时间","回复内容",1,"原帖内容"));
    return act;
  }

  RefreshController _refreshController = RefreshController(
      initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await _ReadHandle();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    // _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
      // floatingActionButton: floatButton,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: FutureBuilder(
            future: _ReadHandle(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: AppColor.bluegreen,),
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
                                  News_print(
                                      snapshot.data[snapshot.data.length -
                                          index - 1]);
                                },
                                child: MessageCard(
                                    data: snapshot.data[snapshot.data.length -
                                        index - 1]),
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
                    margin: EdgeInsets.only(left: 1000),
                    child: CircularProgressIndicator(
                      strokeWidth: 8.0,
                      color: Colors.greenAccent,
                    ));
              }
            }));
  }
}
