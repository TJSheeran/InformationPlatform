import 'package:flutter/material.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'message_card.dart';
import 'Mes.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import '../../dio_util/dio_util.dart';
import 'package:dio/dio.dart' as FormDataA;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/pages/login/login_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<List<Mes>> _ReadHandle() async {
    var result = await DioUtil().request(
      "/message/comment/"+uid.toString(),
      method: DioMethod.get,
      //data: {'uid': '1'},
    );
    List<Mes> act = convertMes(result);
    return act;
  }
    void setRead(id) async {
    var result = await DioUtil().request(
      "/message/setCommentRead/"+id,
      method: DioMethod.get,
    );
    Get.toNamed(Routes.DETAIL, arguments: result[0])?.then((value) {
      if (value != null && value) {
        setState(() {
          _ReadHandle();
        });
      }
    });
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content:Container(
                height: 300,
                width: 800,
                color: Colors.transparent,
                child: Scaffold(
                    backgroundColor: AppColor.page,
                    body: Center(
                        child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                            },
                            child: Container(
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
                                                  top: 25,
                                                  left: 25,
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
                                        top: 30,
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
                                                                width: 700,
                                                                height: 160,
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
                                                                  maxLines: 7,
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
                                )))))));},

    );
  }
  @override
  Widget build(BuildContext context) {
    //initState();
      return Scaffold(
          backgroundColor: AppColor.page,
          appBar: AppBar(
            title: Text(
              "我的消息",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            elevation: 0.5,
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: AppColor.bluegreen,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.toNamed(Routes.TEST);// 处理返回操作
              },
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(
                  top: 14,
                  right: 16,
                ),
                // child: Stack(
                //   children: <Widget>[
                //     Icon(
                //       Icons.notifications,
                //       size: 30,
                //     ),
                //     Positioned(
                //       right: 0,
                //       child: Container(
                //         padding: EdgeInsets.all(1),
                //         decoration: BoxDecoration(
                //           color: Colors.red,
                //           borderRadius: BorderRadius.circular(6),
                //         ),
                //         constraints: BoxConstraints(
                //           minWidth: 14,
                //           minHeight: 14,
                //         ),
                //         child: Text(
                //           '6',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 12,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.announcement,color: Colors.black,size: 40,),
              onPressed: ()  {
                onCreateMedia();
              },
              backgroundColor: AppColor.bluegreen
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                                  setRead(StringId(snapshot.data[snapshot.data.length -
                                           index - 1]));
                                  // Get.toNamed(Routes.DETAIL, arguments: snapshot.data[snapshot.data.length -
                                  //     index - 1]);
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
