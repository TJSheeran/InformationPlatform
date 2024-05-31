import 'dart:io';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/pages/login/login_page.dart';
import 'package:tongxinbaike/pages/mine/modifyInfo_page.dart';
import 'package:tongxinbaike/pages/publish/publish_page.dart';
import 'package:tongxinbaike/pages/root/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import '../home/home_page.dart';
import 'header_widget.dart';
import 'package:tongxinbaike/pages/login/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as FormDataA;
import 'dart:math';
// import 'package:flutter_login_ui/pages/goals_page.dart';
// import 'package:flutter_login_ui/home_page.dart';
// import 'package:flutter_login_ui/pages/widgets/header_widget.dart';

// import 'achievement_page.dart';
// import 'forgot_password_verification_page.dart';
// import 'settings.dart';
class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  Future<List>? flist;
  RefreshController _refreshController = RefreshController(
      initialRefresh: false);
  bool isExpandPlayRecord = true;
  bool isExpandCollect = false;
  //图片
  File? avator;
  bool flag=false;
  Future<List> _ReadHandle() async {
    var result = await DioUtil().request("/userInfoByid/" + uid.toString(),
        method: DioMethod.get, data: {});
    return result;
  }

  Future pickAvator() async {
    try {
      final avator = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (avator == null) return;

      final avatorTemp = File(avator.path);

      setState(() => this.avator = avatorTemp);
    } on PlatformException catch (e) {
      print('加载失败: $e');
    }
  }

  String defaultAvator =
      "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg";
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

  Widget UserHeadWidget(msg){
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 4,
              color: Color.fromARGB(20, 0, 0, 0),
            ),
          ],
        ),

        padding: EdgeInsets.all(15),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Container(
              width: 80,
              height: 80,
              //超出部分，可裁剪
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child:
              CircleAvatar(
                  backgroundColor: Color(0xFFCCCCCC),
                  backgroundImage:
                  msg[0]["picture"]==null?NetworkImage(defaultAvator):NetworkImage(msg[0]["picture"]) //data.userImgUrl),
              ),),
            SizedBox(width: 15,),
            Expanded(
              flex: 1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                  Text(msg[0]["username"],
                    style: TextStyle(
                        color: AppColor.googleblack,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Text(msg[0]['campus']==null?'':msg[0]['campus'],
                      style: TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontSize: 16,
                          )),
              // Text(msg[0]["tju"], style:  TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 14))
            ])),
            IconButton(
                icon: Icon(Icons.border_color_sharp),
                iconSize: 30,
                color: Color.fromRGBO(102, 102, 102, 1),
                onPressed: (){
                  showBarModalBottomSheet(
                  context: context,
                  builder: (context) => ModifyInfoPage(),
                  enableDrag: true,
                  expand: true,
                  duration: const Duration(milliseconds: 400),
                  backgroundColor: Colors.transparent);
                },
              ),
    ]));}

  Widget UserMsgWidget(msg){
      return Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 4,
                color: Color.fromARGB(20, 0, 0, 0),
              ),
            ],
          ),

          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Text(uid.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("注册编号", style:  TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 16))
                  ])),
              Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Text(msg[0]["belikednum"].toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("获赞数", style:  TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 16))
                  ])),
              Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Text(msg[0]["becollectednum"].toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("被收藏数", style:  TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 16))
                  ])),
              Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Text(msg[0]["befollowednum"].toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("粉丝数", style:  TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: 16))
                  ]))]));
    }

  Widget HeaderWidget(List s) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 4,
              color: Color.fromARGB(20, 0, 0, 0),
            ),
          ],
        ),

        padding: EdgeInsets.all(15),
      child: Column(children: <Widget>[
      Container(child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child:Icon(
                Icons.screen_lock_landscape_rounded,
                size: 40,
                color: AppColor.googleblack,
              ),
            ),
      SizedBox(width: 15),
      Text("我的发帖",
          style: TextStyle(
              fontSize: 18,
              color: AppColor.googleblack,
              fontWeight: FontWeight.w600,
          )),
      Expanded(
        flex: 1,
        child: SizedBox(),
      ),
      InkWell(
        child: Transform.rotate(
            angle: (isExpandPlayRecord ? 90 : 0) * pi / 180,
            child: Icon(Icons.arrow_forward_ios)),
        onTap: () {
          setState(() {
            isExpandPlayRecord = !isExpandPlayRecord;
          });
        },
      ),
      ],
    )),
      isExpandPlayRecord ?ListView.builder(
        itemCount: s.length, //告诉ListView总共有多少个cell
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          String avator = defaultAvator;
          if (s[index]['baikeAuthorPic'] != null) {
            avator = s[index]['baikeAuthorPic'];
          }
          return Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
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
                   s[index]["uid"]=uid;
                    Get.toNamed(Routes.DETAIL, arguments: s[index])?.then((value) {
                      if (value != null && value) {
                        setState(() {
                          flist = _ReadHandle();
                        });
                      }
                    }
                    );
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
    ):SizedBox()]));
  }
  Widget MyCollect() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 4,
              color: Color.fromARGB(20, 0, 0, 0),
            ),
          ],
        ),

        padding: EdgeInsets.all(15),
        child: Column(children: <Widget>[
          Container(child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child:Icon(
                  Icons.collections_sharp,
                  size: 40,
                  color: AppColor.googleblack,
                ),
              ),
              SizedBox(width: 15),
              Text("我的收藏",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.googleblack,
                    fontWeight: FontWeight.w600,
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              InkWell(
                child: Transform.rotate(
                    angle: (isExpandCollect ? 90 : 0) * pi / 180,
                    child: Icon(Icons.arrow_forward_ios)),
                onTap: () {
                  setState(() {
                    isExpandCollect = !isExpandCollect;
                  });
                },
              ),
            ],
          )),
          isExpandCollect ?
              FutureBuilder(
              future: _collectHandle(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                  return SizedBox();
              }
              else
              {
                return ListView.builder(
              itemCount: snapshot.data?.length, //告诉ListView总共有多少个cell
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                String avator = defaultAvator;
                if (snapshot.data[index]['baikeAuthorPic'] != null) {
                  avator = snapshot.data[index]['baikeAuthorPic'];
                }
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          Get.toNamed(Routes.DETAIL, arguments:  snapshot.data[index])?.then((value) {
                            if (value != null && value) {
                              setState(() {
                                flist = _ReadHandle();
                              });
                            }
                          }
                          );
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
                                      '${snapshot.data[index]["title"]}',
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
                                        snapshot.data[index]['author'] != null
                                            ? snapshot.data[index]['author']
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
                                snapshot.data[index]["content"]!,
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
          );}}):SizedBox()]));
  }

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

  Future<List> _ReadHandle2() async {
    var result = await DioUtil().request(
      "/userInfoByid/"+uid.toString(),
      method: DioMethod.get,
      //data: {'uid': '1'},
    );
    return result;
    // var result = await DioUtil().request("/recommendByFilter",
    //     method: DioMethod.post, data: {
    //       "userid":131,
    //       "location":longitude+','+latitude
    //     });
    // return result;
  }
    Future<List> _collectHandle() async {
    var result = await DioUtil().request(
    "/getCollectBaike/"+uid.toString(),
      method: DioMethod.get,
    //data: {'uid': '1'},
    );
    return result;
    }
  @override
  void initState() {
    super.initState();
    flist = _ReadHandle();
  }


      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

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

// imageUpload() async {
//   if (avator != null) {
//     var formData = FormDataA.FormData.fromMap({
//       'file': await FormDataA.MultipartFile.fromFile(avator!.path,
//           filename: "test.jpg"),
//     });
//
//     var result = await DioUtil()
//         .request("/fileUpload", method: DioMethod.post, data: formData);
//
//     DioUtil().request("/updatePic", method: DioMethod.post, data: {
//       'username': '111',
//       'picture': result,
//     });
//
//     Fluttertoast.showToast(
//         msg: "修改成功",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.black45,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
// }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColor.page,
    appBar: AppBar(
      title: Text(
        "个人主页",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      iconTheme: IconThemeData(color: Colors.white),
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
      floatingActionButton:
      FloatingActionButton(
          child: Icon(Icons.announcement,color: Colors.black,size: 40,),
          onPressed: ()  {
            onCreateMedia();
          },
          backgroundColor: AppColor.bluegreen
      ),

    drawer: Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.page,
        ),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            DrawerHeader(
              // padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              decoration: BoxDecoration(
                color: AppColor.bluegreen,
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   stops: [0.0, 1.0],
                //   colors: [
                //     Theme.of(context).primaryColor,
                //     AppColor.bluegreen,
                //   ],
                // ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "设 置",
                  style: TextStyle(
                      fontSize: 25,
                      color: AppColor.page,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.screen_lock_landscape_rounded,
                size: _drawerIconSize,
                color: AppColor.active,
              ),
              title: Text(
                '百科主页',
                style: TextStyle(
                    fontSize: 17,
                    color: AppColor.active,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.login_rounded,
                  size: _drawerIconSize, color: AppColor.active),
              title: Text(
                '发布词条',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: AppColor.active,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RootPage()),
                // );
                showBarModalBottomSheet(
                    context: context,
                    builder: (context) => PublishPage(),
                    enableDrag: true,
                    expand: true,
                    duration: const Duration(milliseconds: 400),
                    backgroundColor: Colors.transparent);
              },
            ),
            //Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: Icon(Icons.person_add_alt_1,
                  size: _drawerIconSize, color: AppColor.active),
              title: Text(
                '修改个人信息',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: AppColor.active,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showBarModalBottomSheet(
                    context: context,
                    builder: (context) => ModifyInfoPage(),
                    enableDrag: true,
                    expand: true,
                    duration: const Duration(milliseconds: 400),
                    backgroundColor: Colors.transparent);
              },
            ),
            //Divider(color: Theme.of(context).primaryColor, height: 1,),
            // ListTile(
            //   leading: Icon(
            //     Icons.password_rounded,
            //     size: _drawerIconSize,
            //     color: AppColor.active,
            //   ),
            //   title: Text(
            //     '申请流程',
            //     style: TextStyle(
            //         fontSize: _drawerFontSize,
            //         color: AppColor.active,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => RootPage()),
            //     );
            //   },
            // ),
            // //Divider(color: Theme.of(context).primaryColor, height: 1,),
            // ListTile(
            //   leading: Icon(
            //     Icons.verified_user_sharp,
            //     size: _drawerIconSize,
            //     color: AppColor.active,
            //   ),
            //   title: Text(
            //     '安全设置',
            //     style: TextStyle(
            //         fontSize: _drawerFontSize,
            //         color: AppColor.active,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => RootPage()),
                //     );
                //   },
                // ),
                //Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: _drawerIconSize,
                    color: AppColor.active,
                  ),
                  title: Text(
                    '退出登录',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: AppColor.active,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    ),
        body: FutureBuilder(
          future: _ReadHandle2(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    UserHeadWidget(snapshot.data),
                    SizedBox(height: 10),
                    UserMsgWidget(snapshot.data),
                    SizedBox(height: 10),
                    HeaderWidget(snapshot.data[0]['mybaike']),
                    SizedBox(height: 10),
                    MyCollect()
                  ],
                ),
              );
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
          })
    // body: FutureBuilder(
    //     future: _ReadHandle(),
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       if (snapshot.hasData)
    //         return SingleChildScrollView(
    //           child: Stack(
    //             children: [
    //               Container(
    //                 height: 100,
    //                 child: HeaderWidget(100, false, Icons.house_rounded),
    //               ),
    //               Container(
    //                 alignment: Alignment.center,
    //                 margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
    //                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    //                 child: Column(
    //                   children: [
    //                     InkWell(
    //                         // onTap: () {
    //                         //   pickAvator();
    //                         // },
    //                         child:
    //                             // Container(
    //                             //   width: 100,
    //                             //   height: 100,
    //                             //   decoration: BoxDecoration(
    //                             //       borderRadius: BorderRadius.circular(100),
    //                             //       image: const DecorationImage(
    //                             //           image: NetworkImage(
    //                             //               "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg"))),
    //                             // ),
    //                             Container(
    //                           width: 100,
    //                           height: 100,
    //                           //超出部分，可裁剪
    //                           clipBehavior: Clip.hardEdge,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(50),
    //                           ),
    //                           child: avator != null
    //                               ? Image.file(avator!, fit: BoxFit.cover)
    //                               : Image.network(
    //                                   snapshot.data[0]["picture"],
    //                                   fit: BoxFit.cover,
    //                                 ),
    //                         )),
    //                     SizedBox(
    //                       height: 20,
    //                     ),
    //                     Text(
    //                       snapshot.data[0]["username"],
    //                       style: TextStyle(
    //                           color: AppColor.active,
    //                           fontSize: 22,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                     SizedBox(
    //                       height: 20,
    //                     ),
    //                     Text(
    //                       '已认证用户',
    //                       style: TextStyle(
    //                           fontSize: 16, fontWeight: FontWeight.bold),
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.all(10),
    //                       child: Column(
    //                         children: <Widget>[
    //                           Container(
    //                             padding: const EdgeInsets.only(
    //                                 left: 8.0, bottom: 4.0),
    //                             alignment: Alignment.topLeft,
    //                             child: Text(
    //                               "基本信息",
    //                               style: TextStyle(
    //                                 color: AppColor.active,
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 25,
    //                               ),
    //                               textAlign: TextAlign.left,
    //                             ),
    //                           ),
    //                           Card(
    //                             child: Container(
    //                               alignment: Alignment.topLeft,
    //                               padding: EdgeInsets.all(15),
    //                               child: Column(
    //                                 children: <Widget>[
    //                                   Column(
    //                                     children: <Widget>[
    //                                       ...ListTile.divideTiles(
    //                                         color: Colors.grey,
    //                                         tiles: [
    //                                           ListTile(
    //                                             // contentPadding: EdgeInsets.symmetric(
    //                                             //     horizontal: 14, vertical: 2),
    //                                             leading:
    //                                                 Icon(Icons.my_location),
    //                                             title: Text(
    //                                               "地 址",
    //                                               style: TextStyle(
    //                                                   fontWeight:
    //                                                       FontWeight.w600),
    //                                             ),
    //                                             subtitle: Text(snapshot
    //                                                 .data[0]["campus"]
    //                                                 .toString()),
    //                                           ),
    //                                           ListTile(
    //                                             leading: Icon(Icons.email),
    //                                             title: Text(
    //                                               "邮 箱",
    //                                               style: TextStyle(
    //                                                   fontWeight:
    //                                                       FontWeight.w600),
    //                                             ),
    //                                             subtitle: Text(snapshot
    //                                                 .data[0]["email"]
    //                                                 .toString()),
    //                                           ),
    //                                           ListTile(
    //                                             leading: Icon(Icons.phone),
    //                                             title: Text(
    //                                               "电 话",
    //                                               style: TextStyle(
    //                                                   fontWeight:
    //                                                       FontWeight.w600),
    //                                             ),
    //                                             subtitle: Text(snapshot
    //                                                 .data[0]["phone"]
    //                                                 .toString()),
    //                                           ),
    //                                           ListTile(
    //                                             leading: Icon(Icons.person),
    //                                             title: Text(
    //                                               "生 日",
    //                                               style: TextStyle(
    //                                                   fontWeight:
    //                                                       FontWeight.w600),
    //                                             ),
    //                                             subtitle: Text(snapshot
    //                                                 .data[0]["birthday"]
    //                                                 .toString()),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                     // MaterialButton(
    //                     //   minWidth: 20.0,
    //                     //   height: 40.0,
    //                     //   shape: const StadiumBorder(),
    //                     //   onPressed: () {
    //                     //     imageUpload();
    //                     //   },
    //                     //   color: AppColor.bluegreen,
    //                     //   child: const Text(
    //                     //     '修 改',
    //                     //     style: TextStyle(
    //                     //         color: Colors.white,
    //                     //         fontSize: 20,
    //                     //         fontWeight: FontWeight.bold),
    //                     //   ),
    //                     // )
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       else
    //         return Container();
    //     })
  );
}}
