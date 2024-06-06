import 'dart:io';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tongxinbaike/common/common_config.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/pages/publish/object_util.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/pages/root/root_page.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as FormDataA;
import 'package:tongxinbaike/pages/login/login_page.dart';
import 'package:tongxinbaike/pages/root/root_page.dart';
// import 'package:tongxinbaike/pages/mytest/locate_test.dart';
import 'package:tongxinbaike/pages/mytest/head.dart';
import 'package:flutter_floating/floating/assist/floating_slide_type.dart';
import 'package:flutter_floating/floating/floating.dart';
import 'package:flutter_floating/floating_increment.dart';

import '../../gexControl/userController.dart';
class PublishPage2 extends StatefulWidget {
  PublishPage2({Key? key}) : super(key: key);

  @override
  State<PublishPage2> createState() => _PublishPage2State();
}

class _PublishPage2State extends State<PublishPage2> {

  TextEditingController contentController = TextEditingController()
    ..addListener(() {});
  final userControl = Get.find<UserController>();
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
        'uid': userControl.uid.value,
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
  Widget build(BuildContext context) {
    return Container(
            height: 500,
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
                                                                  .centerLeft,
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
                                                    width: 368,
                                                    height: 145,
                                                    margin: EdgeInsets.only(
                                                        left: 10),
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
                        ))))));
  }
}

