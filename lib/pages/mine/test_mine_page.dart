import 'package:demo711/config/app_colors.dart';
import 'package:demo711/pages/login/login_page.dart';
import 'package:demo711/pages/root/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/home_page.dart';
import 'header_widget.dart';
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
                  color: Colors.black,
                ),
                title: Text(
                  '百科主页',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RootPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize, color: Colors.black),
                title: Text(
                  '发布词条',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Colors.black,
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
                leading: Icon(Icons.person_add_alt_1,
                    size: _drawerIconSize, color: Colors.black),
                title: Text(
                  '修改个人信息',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Colors.black,
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
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Colors.black,
                ),
                title: Text(
                  '申请流程',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Colors.black,
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
                  color: Colors.black,
                ),
                title: Text(
                  '安全设置',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Colors.black,
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
                  color: Colors.black,
                ),
                title: Text(
                  '退出登录',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Colors.black,
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg"))),
                    // BoxDecoration(
                    //   borderRadius: BorderRadius.circular(100),
                    //   border: Border.all(width: 5, color: Colors.white),
                    //   color: Colors.white,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black12,
                    //       blurRadius: 100,
                    //       offset: const Offset(5, 5),
                    //     ),
                    //   ],
                    // ),
                    // child: Image(
                    //   image: NetworkImage(
                    //       "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg"),
                    //   width: 80,
                    //   height: 80,
                    // )
                    // Icon(
                    //   Icons.person,
                    //   size: 80,
                    //   color: Colors.grey.shade300,
                    // ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sheeran',
                    style: TextStyle(
                        color: AppColor.active,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '研二  在校',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "基本信息",
                            style: TextStyle(
                              color: AppColor.active,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          // contentPadding: EdgeInsets.symmetric(
                                          //     horizontal: 14, vertical: 2),
                                          leading: Icon(Icons.my_location),
                                          title: Text(
                                            "学 院",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text("电子与信息工程学院"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text(
                                            "邮 箱",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text("sheeran@163.com"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text(
                                            "电 话",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text("17718216666"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text(
                                            "生 日",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text("1998/03/04"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
