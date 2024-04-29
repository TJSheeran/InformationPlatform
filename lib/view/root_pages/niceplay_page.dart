import 'package:flutter/material.dart';
import 'package:tongxinbaike/pages/home/home_page.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:dio/dio.dart' as FormDataA;
import 'package:tongxinbaike/pages/login/login_page.dart';
// import 'package:tongxinbaike/pages/mytest/locate_test.dart';
import 'package:tongxinbaike/pages/mytest/head.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
class NiceplayPage extends StatefulWidget {
  NiceplayPage({Key? key}) : super(key: key);

  @override
  State<NiceplayPage> createState() => _NiceplayPageState();
}


String defaultAvator =
    "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg";
Widget renderCover() {
  return Stack(
    fit: StackFit.passthrough,
    children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      Positioned(
        left: 0,
        top: 100,
        right: 0,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(0, 0, 0, 0),
                Color.fromARGB(80, 0, 0, 0),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
Widget HeaderWidget(List s) {
  return ListView.builder(
      itemCount: s.length, //告诉ListView总共有多少个cell
      itemBuilder: (BuildContext context, int index) {
        String avator = defaultAvator;
        if (s[index]['baikeAuthorPic'] != null) {
          avator = s[index]['baikeAuthorPic'];
        }
        return Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
            color: AppColor.page,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 4,
                color: Color.fromARGB(20, 0, 0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              renderCover(),

              InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAIL, arguments: s[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child:
                          Text(
                            '${s[index]["title"]}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),),
                          Padding(padding: EdgeInsets.only(left: 10)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xFFCCCCCC),
                              backgroundImage:
                              NetworkImage(avator) //data.userImgUrl),
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                s[index]['author'] != null
                                    ? s[index]['author']
                                    : "TJSheeran",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.bluegreen,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        s[index]["content"]!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

            ],
          ),
        );
      } //使用_cellForRow回调返回每个cell
  );
}

class _NiceplayPageState extends State<NiceplayPage> {

  Future<List>? flist;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

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
  Future<List> _ReadHandle() async {
    var formData = FormDataA.FormData.fromMap({
      "userid":uid,
      "location":longitude+','+latitude
    });
    var result = await DioUtil()
        .request("/recommendByFilter", method: DioMethod.post, data: formData);
    return result;
    // var result = await DioUtil().request("/recommendByFilter",
    //     method: DioMethod.post, data: {
    //       "userid":131,
    //       "location":longitude+','+latitude
    //     });
    // return result;
  }
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
  void initState(){
    super.initState();
    flist = _ReadHandle();
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
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColor.page,
        appBar: AppBar(
          title: Text(
            "发现帖子",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.toNamed(Routes.TEST);// 处理返回操作
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppColor.bluegreen,
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: <Color>[
              //   Theme.of(context).primaryColor,
              //   Theme.of(context).accentColor,
              // ]

              // )
            ),
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
        body:FutureBuilder(
            future: _ReadHandle(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return  SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(backgroundColor: AppColor.purple,),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child:  SizedBox(
                        width: 600,
                                child: HeaderWidget(snapshot.data)));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(left: 1000),
                    child: CircularProgressIndicator(
                      strokeWidth: 8.0,
                      color: AppColor.purple,
                    ));
              }
            }));
            //   return SafeArea(
            //       child: Container(
            //         child: PageView(
            //           children: [
            //             if (snapshot.hasData)
            //               SizedBox(
            //                   height: 520,
            //                   width: 300,
            //                   child: HeaderWidget(snapshot.data))
            //           ],
            //         ),
            //       )
            //   );
            // }));
  }
}


