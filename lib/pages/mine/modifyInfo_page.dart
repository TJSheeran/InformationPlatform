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

class ModifyInfoPage extends StatefulWidget {
  ModifyInfoPage({Key? key}) : super(key: key);

  @override
  State<ModifyInfoPage> createState() => _ModifyInfoPageeState();
}

class _ModifyInfoPageeState extends State<ModifyInfoPage> {
  // String? firstLevelLabel;
  // String? secondLevelLabel;
  // List<String> defaultSecondLevel = ["快递", "空调", "电费", "医保", "寝室", "差旅报销"];

  //图片
  File? image;
  List? futureinfo;
  var targetDate=DateTime(1,1,1);

  TextEditingController userNameController =
      new TextEditingController()..addListener(() {});
  TextEditingController passwordController =
      new TextEditingController()..addListener(() {});
  TextEditingController campusController =
      new TextEditingController()..addListener(() {});
  TextEditingController birthdayController =
      new TextEditingController()..addListener(() {});

  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode campusFocusNode = FocusNode();

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: Color.fromRGBO(240, 240, 240, 1),
    ),
  );

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
  Future<List> _ReadHandle() async {
    var result = await DioUtil().request("/userInfoByid/"+uid.toString(),
        method: DioMethod.get, data: {});
    return result;
  }
  imageUpload() async {
    if (image != null) {
      var formData = FormDataA.FormData.fromMap({
        'file': await FormDataA.MultipartFile.fromFile(image!.path,
            filename: "test.jpg"),
        'uid':uid
      });
      await DioUtil()
          .request("/uploadPic", method: DioMethod.post, data: formData);
    }
    await DioUtil()
        .request("/updateUserInfoByid", method: DioMethod.post,
        data: {"uid": uid, "username": userNameController.text, "password": passwordController.text,
                "birthday": "${targetDate.year.toString()}/${targetDate.month.toString().padLeft(2, '0')}/${targetDate.day.toString().padLeft(2, '0')}",
                "campus":campusController.text
        });

    Fluttertoast.showToast(
        msg: "修改成功",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  Future<void> aAsyncMethod() async {
    futureinfo = await _ReadHandle();
    userNameController.text=  futureinfo?[0]["username"];
    passwordController.text = futureinfo?[0]["password"];
    campusController.text = futureinfo?[0]["campus"];
    if(futureinfo?[0]["birthday"] != null)
    {List<String> datalist=futureinfo?[0]["birthday"].split("/");
    targetDate = DateTime(int.parse(datalist[0]), int.parse(datalist[1]), int.parse(datalist[2]));}
  }
    // do something async hree
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aAsyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
            color: Colors.transparent,
            child: FutureBuilder(
            future: _ReadHandle(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData)
              {
              return Scaffold(
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
                                            child: Text('返回'.tr,
                                                style: TextStyle(
                                                    color: AppColor.bluegreen,
                                                    fontSize: 18)),
                                          )),
                                      Positioned(
                                          top: 20,
                                          right: 20,
                                          child: InkWell(
                                            onTap: () {
                                              imageUpload();
                                              Fluttertoast.showToast(
                                                  msg: "保存成功",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Colors.black45,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              Navigator.of(context).pop();
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
                                              child: Text('保存'.tr,
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
                                                  InkWell(
                                                      onTap: () {
                                                        pickImage();
                                                      },
                                                      child:
                                                      // Container(
                                                      //   width: 100,
                                                      //   height: 100,
                                                      //   decoration: BoxDecoration(
                                                      //       borderRadius: BorderRadius.circular(100),
                                                      //       image: const DecorationImage(
                                                      //           image: NetworkImage(
                                                      //               "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg"))),
                                                      // ),
                                                      Container(
                                                        width: 100,
                                                        height: 100,
                                                        //超出部分，可裁剪
                                                        clipBehavior: Clip.hardEdge,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                        ),
                                                        child: image != null
                                                            ? Image.file(image!, fit: BoxFit.cover)
                                                            : Image.network(
                                                          snapshot.data[0]["picture"],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )),
                                                  // Container(
                                                  //     margin: EdgeInsets.only(
                                                  //       left: 10,
                                                  //     ),
                                                  //     child: Row(
                                                  //       crossAxisAlignment:
                                                  //           CrossAxisAlignment
                                                  //               .center,
                                                  //       children: [
                                                  //         SizedBox(
                                                  //           width: 115,
                                                  //         ),
                                                  //         Container(
                                                  //           width: 100,
                                                  //           height: 100,
                                                  //           decoration: BoxDecoration(
                                                  //               borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                           50),
                                                  //               image: const DecorationImage(
                                                  //                   image: NetworkImage(
                                                  //                       "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg"))),
                                                  //         ),
                                                  //       ],
                                                  //     )),

                                                  SizedBox(
                                                    height: 10,
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
                                                                  '用户名'.tr,
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
                                                          userNameController,
                                                      focusNode:
                                                          userNameFocusNode,
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
                                                                  '密 码'.tr,
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
                                                      obscureText: true,
                                                      controller:
                                                          passwordController,
                                                      focusNode:
                                                          passwordFocusNode,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: AppColor.active,
                                                      ),
                                                      maxLines: 1,
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
                                                                  '生 日'.tr,
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
                                                    width: 130,
                                                    height: 35,
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            240, 240, 240, 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    alignment: Alignment.center,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          DatePicker.showDatePicker(
                                                              context,
                                                              showTitleActions:
                                                                  true,
                                                              minTime: DateTime(
                                                                  1950, 1, 1),
                                                              maxTime: DateTime(
                                                                  2024, 1, 1),
                                                              theme: DatePickerTheme(
                                                                  headerColor:
                                                                      AppColor
                                                                          .nav,
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .nav,
                                                                  itemStyle: TextStyle(
                                                                      color: AppColor
                                                                          .active,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                          18),
                                                                  doneStyle: TextStyle(
                                                                      color: AppColor.active,
                                                                      fontSize: 16)),
                                                              onConfirm: (date) {
                                                            setState(() {
                                                              targetDate = date;
                                                            });
                                                            // print(targetDate);
                                                          }, currentTime: DateTime.now(), locale: LocaleType.zh);
                                                        },
                                                        child: Text(
                                                          "${targetDate.year.toString()}/${targetDate.month.toString().padLeft(2, '0')}/${targetDate.day.toString().padLeft(2, '0')}",
                                                          style: TextStyle(
                                                            color:
                                                                AppColor.active,
                                                            fontSize: 18,
                                                          ),
                                                        )
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
                                                                  '学院'.tr,
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
                                                          campusController,
                                                      focusNode:
                                                          campusFocusNode,
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
                        )))));}
            else
              return Container();}
)
    ));
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
