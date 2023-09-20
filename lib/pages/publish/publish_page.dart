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
class PublishPage extends StatefulWidget {
  PublishPage({Key? key}) : super(key: key);

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  String? firstLevelLabel;
  String? secondLevelLabel;
  List<String> defaultSecondLevel = ["快递", "空调", "电费", "医保", "寝室", "差旅报销"];

  //图片
  File? image;

  TextEditingController titleController = TextEditingController()
    ..addListener(() {});
  TextEditingController contentController = TextEditingController()
    ..addListener(() {});
  TextEditingController firstLevelController = TextEditingController()
    ..addListener(() {});
  TextEditingController secondLevelController = TextEditingController()
    ..addListener(() {});

  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: Color.fromRGBO(240, 240, 240, 1),
    ),
  );

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
                      defaultSecondLevel = levelMap[e]!;
                    });

                    // if (personFocusNode.hasFocus) {
                    //   personFocusNode.unfocus();
                    // }

                    firstLevelController.text = "";
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

                    // if (personFocusNode.hasFocus) {
                    //   personFocusNode.unfocus();
                    // }

                    secondLevelController.text = "";
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('加载失败: $e');
    }
  }

  Future pickImagefromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('加载失败: $e');
    }
  }

  Future cleanImage() async {
    setState(() {
      this.image = null;
    });
  }

  imageUpload(String? firstlevel,String? secondlevel,String titletext,String contenttext) async {
    if(image != null)
    {
      var formData = FormDataA.FormData.fromMap({
        'file': await FormDataA.MultipartFile.fromFile(image!.path, filename:"test.jpg"),
        'category1': firstlevel,
        'category2': secondlevel,
        'title': titletext,
        'uid': uid,
        'content': contenttext,
        'campus':"嘉定校区",
      });

      DioUtil().request("/fileUpload", method: DioMethod.post, data: formData);
    }
    else{
      var formData = FormDataA.FormData.fromMap({
        'category1': firstlevel,
        'category2': secondlevel,
        'title': titletext,
        'uid': uid,
        'content': contenttext,
        'campus':"嘉定校区",
      });

      DioUtil().request("/fileUpload", method: DioMethod.post, data: formData);
      // Fluttertoast.showToast(
      //     msg: "未上传图片",
      //     toastLength:
      //     Toast.LENGTH_SHORT,
      //     gravity:
      //     ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor:
      //     Colors.black45,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
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
                                              print(firstLevelLabel);
                                              print(secondLevelLabel);
                                              print(titleController.text);
                                              print(contentController.text);
                                              // imageUpload();
                                              // Navigator.of(context).pop();
                                              if (nowtimestamp != '' &&
                                                  firstLevelLabel != null && secondLevelLabel != null
                                              && titleController.text != ''&&contentController.text !='') {
                                                imageUpload(firstLevelLabel,secondLevelLabel,titleController.text,contentController.text);

                                                  // var formData = FormDataA.FormData.fromMap({
                                                  //   'file':FormDataA.MultipartFile.fromFile(image!.path, filename:"test.jpg"),
                                                  //   'category1': firstLevelLabel,
                                                  //   'category2': secondLevelLabel,
                                                  //   'title': titleController.text,
                                                  //   'author': "Linhai",
                                                  //   'content': contentController.text,
                                                  //   'campus':"嘉定校区",
                                                  // });
                                                  // DioUtil().request("/fileUpload", method: DioMethod.post, data: formData);
                                                // DioUtil().request(
                                                //   "/addBaike",
                                                //   method: DioMethod.post,
                                                //   data: {
                                                //     'category1': firstLevelLabel,
                                                //     'category2': secondLevelLabel,
                                                //     'title': titleController.text,
                                                //     'author': "Linhai",
                                                //     'content': contentController.text,
                                                //   },
                                                // );
                                                // Fluttertoast.showToast(
                                                //     msg: "发布成功",
                                                //     toastLength:
                                                //         Toast.LENGTH_SHORT,
                                                //     gravity:
                                                //         ToastGravity.BOTTOM,
                                                //     timeInSecForIosWeb: 1,
                                                //     backgroundColor:
                                                //         Colors.black45,
                                                //     textColor: Colors.white,
                                                //     fontSize: 16.0);
                                                // Navigator.of(context).pop();
                                               }
                                              else if(firstLevelLabel == null || secondLevelLabel == null)
                                                {
                                                  Fluttertoast.showToast(
                                                          msg: "一二级目录不能为空！",
                                                          toastLength:
                                                              Toast.LENGTH_SHORT,
                                                          gravity:
                                                              ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.black45,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0);
                                                }
                                              else if(titleController.text == '' || contentController.text =='')
                                              {
                                                Fluttertoast.showToast(
                                                    msg: "发布标题和内容不能为空！",
                                                    toastLength:
                                                    Toast.LENGTH_SHORT,
                                                    gravity:
                                                    ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
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
                                                        top: 5.0,
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
                                                        top: 15.0,
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
                                                          titleController,
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

                                                  // Container(
                                                  //     margin: EdgeInsets.only(
                                                  //       left: 10,
                                                  //     ),
                                                  //     child: Column(
                                                  //       crossAxisAlignment:
                                                  //           CrossAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  //         Container(
                                                  //             height: 60,
                                                  //             // color: Colors.orange,
                                                  //             alignment: Alignment
                                                  //                 .centerLeft,
                                                  //             child: Text(
                                                  //                 '选择图片'.tr,
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   color: AppColor
                                                  //                       .active,
                                                  //                   fontSize:
                                                  //                       18.0,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .w600,
                                                  //                 ))),
                                                  //       ],
                                                  //     )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: Row(
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
                                                                  '选择图片'.tr,
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
                                                          SizedBox(width: 230),
                                                          InkWell(
                                                            onTap: () {
                                                              cleanImage();
                                                            },
                                                            child: Container(
                                                                height: 60,
                                                                // color: Colors.orange,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    '清 除'.tr,
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColor
                                                                          .unactive,
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ))),
                                                          ),
                                                        ],
                                                      )),

                                                  InkWell(
                                                    onTap: () {
                                                      pickImage();
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: image != null
                                                          ? Image.file(
                                                              image!,
                                                              width: 120,
                                                              height: 120,
                                                            )
                                                          : SvgPicture.asset(
                                                              "assets/icons/add_image.svg",
                                                              width: Get.width *
                                                                  .2,
                                                            ),
                                                    ),
                                                  ),

                                                  // Center(
                                                  //   child: Column(
                                                  //     children: [
                                                  //       MaterialButton(
                                                  //           color: AppColor
                                                  //               .bluegreen,
                                                  //           child: Text(
                                                  //             "图库选择图片",
                                                  //             style: TextStyle(
                                                  //                 color: Colors
                                                  //                     .white),
                                                  //           ),
                                                  //           onPressed: () {
                                                  //             pickImage();
                                                  //           }),
                                                  //       MaterialButton(
                                                  //           color: AppColor
                                                  //               .bluegreen,
                                                  //           child: Text(
                                                  //             "相机选择图片",
                                                  //             style: TextStyle(
                                                  //                 color: Colors
                                                  //                     .white),
                                                  //           ),
                                                  //           onPressed: () {
                                                  //             pickImagefromCamera();
                                                  //           }),
                                                  //       SizedBox(
                                                  //         height: 20,
                                                  //       ),
                                                  //       image != null
                                                  //           ? Image.file(image!)
                                                  //           : Text("没有图片")
                                                  //     ],
                                                  //   ),
                                                  // ),

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
