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
      "/getMyBaike/"+uid.toString(),
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
          child: Stack(
            children: <Widget>[
              Icon(
                Icons.notifications,
                size: 30,
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '6',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        )
      ],
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
            ListTile(
              leading: Icon(
                Icons.password_rounded,
                size: _drawerIconSize,
                color: AppColor.active,
              ),
              title: Text(
                '申请流程',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: AppColor.active,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage()),
                );
              },
            ),
            //Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: Icon(
                Icons.verified_user_sharp,
                size: _drawerIconSize,
                color: AppColor.active,
              ),
              title: Text(
                '安全设置',
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: AppColor.active,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage()),
                );
              },
            ),
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
              return
                Container(
                    padding: EdgeInsets.all(10),
                    child:
                    HeaderWidget(snapshot.data));
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
