import 'dart:ui';

import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/pages/home/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailController detailController = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    //arguments传参
    News news = Get.arguments;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
            color: Colors.transparent,
            child: Scaffold(
                backgroundColor: AppColor.page,
                body: SafeArea(
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
                        top: 20,
                        bottom: 0,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(bottom: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      padding:
                                          EdgeInsets.only(left: 0.0, right: 0),
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
                                          // Offstage(
                                          //     offstage: widget
                                          //             .taskEditMode ==
                                          //         TaskEditMode
                                          //             .TaskEditMode_Edit,
                                          // child:

                                          // CircleAvatar(
                                          //     radius: 30,
                                          //     backgroundColor:
                                          //         Color(0xFFCCCCCC),
                                          //     backgroundImage: NetworkImage(
                                          //         "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                          //     ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, right: 0.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 15.0,
                                                      bottom: 0.0),
                                                  child: CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Color(0xFFCCCCCC),
                                                      backgroundImage: NetworkImage(
                                                          "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                                      ),
                                                ),
                                                SizedBox(width: 30),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      news.name!,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColor.purple,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2)),
                                                    Text(
                                                      news.date!, //data.description,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF999999),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 20),

                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, right: 0.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 15.0,
                                                      bottom: 0.0),
                                                  child: Text('活动标签'.tr,
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 15),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${news.label}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, right: 0.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 15.0,
                                                      bottom: 0.0),
                                                  child: Text('活动人数'.tr,
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 15),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${news.userNumber}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, right: 0.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 15.0,
                                                      bottom: 0.0),
                                                  child: Text('活动时间'.tr,
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 190,
                                                  height: 35,
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 15),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.bluegreen,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${news.activityDate}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, right: 0.0, top: 2),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 15.0,
                                                      bottom: 0.0),
                                                  child: Text('内容详情'.tr,
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   height: 0.5,
                                          //   color: Color.fromRGBO(250, 250, 250, 1),
                                          // ),
                                          // Offstage(
                                          //     offstage: widget
                                          //             .taskEditMode ==
                                          //         TaskEditMode
                                          //             .TaskEditMode_Edit,
                                          //     child:

                                          // Offstage(
                                          //     offstage: widget
                                          //             .taskEditMode ==
                                          //         TaskEditMode
                                          //             .TaskEditMode_Edit,
                                          //     child:

                                          // Offstage(
                                          //     offstage: widget
                                          //             .taskEditMode ==
                                          //         TaskEditMode
                                          //             .TaskEditMode_Edit,
                                          //     child:
                                          SizedBox(
                                            height: 20,
                                          ),

                                          Container(
                                              width: 330,
                                              height: 80,
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  top: 10,
                                                  right: 15,
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      240, 240, 240, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "${news.text}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )),

                                          SizedBox(height: 15),

                                          Divider(
                                              height: 10.0,
                                              thickness: 1.0,
                                              indent: 0.0,
                                              endIndent: 0.0,
                                              color: AppColor.grey),

                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, right: 0.0, top: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 0.0),
                                                  child: Text('评论列表'.tr,
                                                      style: TextStyle(
                                                        color: AppColor.active,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 220),

                                          InkWell(
                                            onTap: () {
                                              print("立即加入");
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  color: AppColor.purple),
                                              width: 500,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: Text('立即加入'.tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            )
                          ],
                        )))
                  ],
                ))))));
  }
}
