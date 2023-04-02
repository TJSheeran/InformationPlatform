import 'dart:ui';
import 'package:demo711/common/common_config.dart';
import 'package:demo711/config/app_colors.dart';
import 'package:demo711/pages/publish/object_util.dart';
import 'package:flutter/material.dart';
import 'package:demo711/pages/root/root_page.dart';
import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/news.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:demo711/routes/app_routes.dart';
import 'package:intl/intl.dart';

class PublishPage extends StatefulWidget {
  PublishPage({Key? key}) : super(key: key);

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  String? firstLevelLabel;
  String? secondLevelLabel;

  var targetDate = DateTime(2022, 01, 01);
  var targetTime = DateTime(2022, 01, 01);

  TextEditingController nameController = TextEditingController()
    ..addListener(() {});
  TextEditingController targetPersonNumberController = TextEditingController()
    ..addListener(() {});
  TextEditingController textController = TextEditingController()
    ..addListener(() {});
  TextEditingController labelController = TextEditingController()
    ..addListener(() {});
  FocusNode personFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: Color.fromRGBO(240, 240, 240, 1),
    ),
  );

  // Widget? _renderTargetPersonNumber() {
  //   return Wrap(
  //       direction: Axis.horizontal,
  //       alignment: WrapAlignment.start,
  //       spacing: 16.0,
  //       runAlignment: WrapAlignment.start,
  //       runSpacing: 16.0,
  //       children: defaultTargetPersonNumber
  //           .map(
  //             (e) => InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     targetDays = e;
  //                   });

  //                   if (focusNode.hasFocus) {
  //                     focusNode.unfocus();
  //                   }

  //                   targetPersonNumberController.text = "";
  //                 },
  //                 child: Container(
  //                     width: 90,
  //                     height: 35,
  //                     decoration: BoxDecoration(
  //                         color: targetDays == e
  //                             ? AppColor.green
  //                             : Color.fromRGBO(240, 240, 240, 1),
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(10.0))),
  //                     alignment: Alignment.center,
  //                     child: Text(e.toString(),
  //                         style: TextStyle(
  //                             color: targetDays == e
  //                                 ? Colors.white
  //                                 : AppColor.purple,
  //                             fontSize: 16.0,
  //                             fontWeight: FontWeight.w400)))),
  //           )
  //           .toList());
  // }

  Widget? _renderFirstLevel() {
    return Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: 16.0,
        runAlignment: WrapAlignment.start,
        runSpacing: 16.0,
        children: defaultFirstLevel
            .map(
              (e) => InkWell(
                  onTap: () {
                    setState(() {
                      firstLevelLabel = e;
                    });

                    if (personFocusNode.hasFocus) {
                      personFocusNode.unfocus();
                    }

                    labelController.text = "";
                  },
                  child: Container(
                      width: 80,
                      height: 35,
                      decoration: BoxDecoration(
                          color: firstLevelLabel == e
                              ? AppColor.green
                              : Color.fromRGBO(240, 240, 240, 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      alignment: Alignment.center,
                      child: Text(e.toString(),
                          style: TextStyle(
                              color: firstLevelLabel == e
                                  ? Colors.white
                                  : AppColor.active,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)))),
            )
            .toList());
  }

  Widget? _renderSecondLevel() {
    return Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: 16.0,
        runAlignment: WrapAlignment.start,
        runSpacing: 16.0,
        children: defaultSecondLevel
            .map(
              (e) => InkWell(
                  onTap: () {
                    setState(() {
                      secondLevelLabel = e;
                    });

                    if (personFocusNode.hasFocus) {
                      personFocusNode.unfocus();
                    }

                    labelController.text = "";
                  },
                  child: Container(
                      width: 80,
                      height: 35,
                      decoration: BoxDecoration(
                          color: secondLevelLabel == e
                              ? AppColor.yellow
                              : Color.fromRGBO(240, 240, 240, 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      alignment: Alignment.center,
                      child: Text(e.toString(),
                          style: TextStyle(
                              color: secondLevelLabel == e
                                  ? Colors.white
                                  : AppColor.active,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)))),
            )
            .toList());
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   title: Text('活动发布页'),
  //     // ),
  //     body: Padding(
  //       padding: EdgeInsets.all(10),
  //       child: ListView(
  //         children: <Widget>[
  //           Container(
  //               alignment: Alignment.center,
  //               padding: EdgeInsets.all(10),
  //               child: Text(
  //                 '发布活动',
  //                 style: TextStyle(
  //                     color: AppColor.purple,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 20),
  //               )),
  //           Container(
  //             padding: EdgeInsets.all(10),
  //             child: TextField(
  //               controller: nameController,
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: 'username',
  //               ),
  //             ),
  //           ),
  //           // Container(
  //           //   padding: EdgeInsets.all(10),
  //           //   child: TextField(
  //           //     controller: dateController,
  //           //     decoration: InputDecoration(
  //           //       border: OutlineInputBorder(),
  //           //       labelText: 'date',
  //           //     ),
  //           //   ),
  //           // ),

  //           Container(
  //             padding: EdgeInsets.all(10),
  //             child: TextField(
  //               controller: textController,
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: 'text',
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 10.0,
  //           ),
  //           Container(
  //             height: 50,
  //             padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //             child: MaterialButton(
  //               minWidth: 10.0,
  //               height: 60.0,
  //               shape: const StadiumBorder(),
  //               onPressed: () {
  //                 print(nameController.text);
  //                 print(textController.text);
  //                 //获取当前的时间
  //                 DateTime date = DateTime.now();
  //                 //组合
  //                 String timestamp =
  //                     "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
  //                 print(timestamp); //2021-12-05 21:52
  //                 //print(DateTime.now());
  //                 if (nameController.text != '' && textController.text != '') {
  //                   DioUtil().request(
  //                     "/add",
  //                     method: DioMethod.post,
  //                     data: {
  //                       'name': nameController.text,
  //                       'text': textController.text,
  //                       'date': timestamp,
  //                       'likeCount': 0,
  //                       'commentCount': 0,
  //                     },
  //                   );
  //                   Fluttertoast.showToast(
  //                       msg: "发布成功",
  //                       toastLength: Toast.LENGTH_SHORT,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 1,
  //                       backgroundColor: Colors.black45,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0);
  //                   Get.toNamed(Routes.ROOT);
  //                 }
  //               },
  //               color: AppColor.purple,
  //               child: const Text(
  //                 '发 布',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 20.0,
  //           ),
  //           Container(
  //             height: 50,
  //             padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //             child: MaterialButton(
  //               minWidth: 10.0,
  //               height: 60.0,
  //               shape: const StadiumBorder(),
  //               onPressed: () {
  //                 Get.toNamed(Routes.ROOT);
  //               },
  //               color: AppColor.purple,
  //               child: const Text(
  //                 '返 回',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
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
                                      // Container(
                                      //     alignment: Alignment.center,
                                      //     child: Text('发布活动',
                                      //         style: TextStyle(
                                      //             color: AppColor.purple,
                                      //             fontSize: 20,
                                      //             fontWeight:
                                      //                 FontWeight.w500))),

                                      // Positioned(
                                      //     top: 20,
                                      //     left: 178,
                                      //     child: InkWell(
                                      //       onTap: () {
                                      //         Navigator.of(context).pop();
                                      //       },
                                      //       child: Text('发布活动'.tr,
                                      //           style: TextStyle(
                                      //               color: Colors.black,
                                      //               fontSize: 20)),
                                      //     )),
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
                                              print(nowtimestamp);

                                              String targettimestamp =
                                                  "${targetDate.year.toString()}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')} ${targetDate.hour.toString().padLeft(2, '0')}:${targetDate.minute.toString().padLeft(2, '0')}:${targetDate.second.toString().padLeft(2, '0')}";
                                              print(targettimestamp);
                                              print(textController.text);
                                              if (targettimestamp != '' &&
                                                  textController.text != '') {
                                                DioUtil().request(
                                                  "/add",
                                                  method: DioMethod.post,
                                                  data: {
                                                    'name': 'New',
                                                    'date': nowtimestamp,
                                                    'text': textController.text,
                                                    'likeCount': 0,
                                                    'commentCount': 0,
                                                    'userid': '11',
                                                    'activityDate':
                                                        targettimestamp,
                                                    'isLiked': false,
                                                    'isFollowed': false
                                                  },
                                                );
                                                Fluttertoast.showToast(
                                                    msg: "发布成功",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black45,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                Navigator.of(context).pop();
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
                                              child: Text('发布'.tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ),
                                          ))
                                    ]))),
                            Positioned(
                                left: 0,
                                right: 0,
                                top: 60,
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
                                                  // Offstage(
                                                  //     offstage: widget
                                                  //             .taskEditMode ==
                                                  //         TaskEditMode
                                                  //             .TaskEditMode_Edit,
                                                  // child:
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 15.0,
                                                        bottom: 0.0),
                                                    child: Text('一级目录'.tr,
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.active,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
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
                                                  Container(
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 10.0,
                                                          right: 0.0),
                                                      // color: Colors.red,
                                                      child:
                                                          _renderFirstLevel()),
                                                  // Offstage(
                                                  //     offstage: widget
                                                  //             .taskEditMode ==
                                                  //         TaskEditMode
                                                  //             .TaskEditMode_Edit,
                                                  //     child:

                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 25.0,
                                                        bottom: 0.0),
                                                    child: Text('二级目录'.tr,
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.active,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
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
                                                  Container(
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 10.0,
                                                          right: 0.0),
                                                      // color: Colors.red,
                                                      child:
                                                          _renderSecondLevel()),

                                                  // Offstage(
                                                  //     offstage: widget
                                                  //             .taskEditMode ==
                                                  //         TaskEditMode
                                                  //             .TaskEditMode_Edit,
                                                  //     child:

                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 15),
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
                                                                  '标 题'.tr,
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
                                                    height: 45,
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
                                                          textController,
                                                      focusNode: titleFocusNode,
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

                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 15),
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
                                                                  '详细内容'.tr,
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
                                                          textController,
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

                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: []))
                                                ],
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                )))
                          ],
                        )))))));
  }
}

class InputDaysFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // print("oldvalue = " + oldValue.text);
    // print("newValue = " + newValue.text);

    if (oldValue.text.length <= 0 && newValue.text == "0") {
      return oldValue;
    }

    if (newValue.text == "") {
      return newValue;
    }

    if (int.parse(newValue.text) > 20) {
      return oldValue;
    }

    return newValue;
  }
}

class GridViewLabelSelect extends StatefulWidget {
  GridViewLabelSelect({Key? key}) : super(key: key);

  @override
  State<GridViewLabelSelect> createState() => _GridViewLabelSelectState();
}

class _GridViewLabelSelectState extends State<GridViewLabelSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: 10,
          //子布局排列方式
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.0,
            crossAxisCount: 4,
          ),
          //子布局构建器
          itemBuilder: (BuildContext context, int index) {
            return GridViewItemWidget();
          }),
    );
  }
}

class GridViewItemWidget extends StatefulWidget {
  GridViewItemWidget({Key? key}) : super(key: key);

  @override
  State<GridViewItemWidget> createState() => _GridViewItemWidgetState();
}

class _GridViewItemWidgetState extends State<GridViewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.page,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 6,
              bottom: 6,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.bluegreen,
                    borderRadius: BorderRadius.all(Radius.circular(22))),
              )),
        ],
      ),
    );
  }
}
