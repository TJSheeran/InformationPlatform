import 'dart:ffi';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/pages/home/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../dio_util/dio_method.dart';
import '../../dio_util/dio_util.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailController detailController = Get.find<DetailController>();
  bool isSubscribed = false;
  bool dataisLiked = false;
  bool isDisLiked = false;
  bool isCollected = false;
  int likeCount = 6;
  FocusNode commentFocusNode = FocusNode();
  TextEditingController commentController = TextEditingController()
    ..addListener(() {});

  Future subscribed() async {
    setState(() {
      this.isSubscribed = !isSubscribed;
    });
    if (isSubscribed) {
      Fluttertoast.showToast(
          msg: "关注成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // 点赞
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // /// send your request here
    // // final bool success= await sendRequest();
    // final result = await DioUtil().request(
    //   "/update",
    //   method: DioMethod.post,
    //   data: {
    //     'id': data.id,
    //     'name': data.name,
    //     'text': data.text,
    //     'date': data.date,
    //     'likeCount': data.isLiked!
    //         ? isLiked
    //             ? data.likeCount! - 1
    //             : data.likeCount!
    //         : isLiked
    //             ? data.likeCount!
    //             : data.likeCount! + 1,
    //     'commentCount': data.commentCount,
    //     'isLiked': !isLiked,
    //     'isFollowed': data.isFollowed,
    //     'likedId': data.likedId,
    //     'commentId': data.commentId,
    //     'userid': data.userid,
    //     'label': data.label,
    //     'activityDate': data.activityDate,
    //     'userNumber': data.userNumber
    //   },
    // );

    /// if failed, you can do nothing
    setState(() {
      dataisLiked = !isLiked;
      likeCount = dataisLiked
          ? dataisLiked
              ? likeCount + 1
              : likeCount
          : dataisLiked
              ? likeCount
              : likeCount - 1;
      if (isDisLiked) {
        isDisLiked = !isDisLiked;
      }
    });
    if (dataisLiked) {
      Fluttertoast.showToast(
          msg: "点赞成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return dataisLiked;
  }

  // 点踩
  Future<bool> onDisLikeButtonTapped(bool isLiked) async {
    setState(() {
      isDisLiked = !isLiked;

      if (dataisLiked) {
        dataisLiked = !dataisLiked;

        likeCount = isDisLiked
            ? isDisLiked
                ? likeCount - 1
                : likeCount
            : isDisLiked
                ? likeCount
                : likeCount + 1;
      }
    });
    if (isDisLiked) {
      Fluttertoast.showToast(
          msg: "点踩成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return isDisLiked;
  }

  // 收藏
  Future<bool> onCollectButtonTapped(bool isLiked) async {
    setState(() {
      isCollected = !isLiked;
    });
    if (isCollected) {
      Fluttertoast.showToast(
          msg: "收藏成功，到收藏夹里看看吧",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return isCollected;
  }

  @override
  Widget build(BuildContext context) {
    //arguments传参
    Map s = Get.arguments;

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
                                top: 20,
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
                                                  left: 10, right: 15),
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
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0,
                                                                      top: 15.0,
                                                                      bottom:
                                                                          0.0),
                                                              child: Text(
                                                                  s["title"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          0.0,
                                                                      top: 10.0,
                                                                      bottom:
                                                                          0.0),
                                                              child: LikeButton(
                                                                isLiked:
                                                                    isCollected,
                                                                likeBuilder: (bool
                                                                    isLiked) {
                                                                  return Icon(
                                                                    isLiked
                                                                        ? Icons
                                                                            .star_rounded
                                                                        : Icons
                                                                            .star_border_rounded,
                                                                    color: isLiked
                                                                        ? AppColor
                                                                            .warning
                                                                        : Colors
                                                                            .grey,
                                                                    size: 35,
                                                                  );
                                                                },
                                                                // likeCount: 8,
                                                                onTap:
                                                                    onCollectButtonTapped,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          0.0,
                                                                      top: 10.0,
                                                                      bottom:
                                                                          0.0),
                                                              child: Text(
                                                                  s[
                                                                      "category1"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xFF999999),
                                                                  )),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 3.0,
                                                                      right:
                                                                          3.0,
                                                                      top: 10.0,
                                                                      bottom:
                                                                          0.0),
                                                              child: Text("·",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xFF999999),
                                                                  )),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 0.0,
                                                                      right:
                                                                          0.0,
                                                                      top: 10.0,
                                                                      bottom:
                                                                          0.0),
                                                              child: Text(
                                                                  s[
                                                                      "category2"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xFF999999),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Divider(
                                                      height: 10.0,
                                                      thickness: 1.0,
                                                      indent: 0.0,
                                                      endIndent: 0.0,
                                                      color: AppColor.grey),

                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 0.0, right: 0.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 15.0,
                                                                  bottom: 0.0),
                                                          child: CircleAvatar(
                                                              radius: 22,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFCCCCCC),
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                                              ),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              "郭雨凡",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColor
                                                                    .bluegreen,
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            2)),
                                                            Text(
                                                              s["campus"], //data.description,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF999999),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 130,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            subscribed();
                                                          },
                                                          child: isSubscribed
                                                              ? Container(
                                                                  width: 80,
                                                                  height: 35,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              15),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .bluegreen,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "已关注",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .page,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 80,
                                                                  height: 35,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              15),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .bluegreen
                                                                          .withOpacity(
                                                                              0.2),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "+ 关 注",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .bluegreen,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 0.0,
                                                        top: 10.0,
                                                        bottom: 0.0),
                                                    child: Text("66人赞同了该回答",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xFF999999),
                                                        )),
                                                  ),

                                                  SizedBox(height: 16),

                                                  Container(
                                                      width: 340,
                                                      height: 180,
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      padding: EdgeInsets.only(
                                                          left: 0,
                                                          top: 0,
                                                          right: 15,
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: AppColor.page,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        s["content"],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8)),
                                                      )),

                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 0.0,
                                                            top: 10.0,
                                                            bottom: 0.0),
                                                        child: Text(
                                                            "发布于 2023-03-06 18:36",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xFF999999),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 60,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 0.0,
                                                            top: 10.0,
                                                            bottom: 0.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                LikeButton(
                                                                  isLiked:
                                                                      dataisLiked,
                                                                  likeBuilder:
                                                                      (isLiked) {
                                                                    return Icon(
                                                                      isLiked
                                                                          ? Icons
                                                                              .thumb_up_alt_rounded
                                                                          : Icons
                                                                              .thumb_up_alt_outlined,
                                                                      color: isLiked
                                                                          ? AppColor
                                                                              .danger
                                                                          : Colors
                                                                              .grey,
                                                                    );
                                                                  },
                                                                  likeCount:
                                                                      likeCount,
                                                                  onTap:
                                                                      onLikeButtonTapped,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                LikeButton(
                                                                  isLiked:
                                                                      isDisLiked,
                                                                  likeBuilder:
                                                                      (isLiked) {
                                                                    return Icon(
                                                                      isLiked
                                                                          ? Icons
                                                                              .thumb_down_alt_rounded
                                                                          : Icons
                                                                              .thumb_down_alt_rounded,
                                                                      color: isLiked
                                                                          ? AppColor
                                                                              .info
                                                                          : Colors
                                                                              .grey,
                                                                    );
                                                                  },
                                                                  // likeCount: 8,
                                                                  onTap:
                                                                      onDisLikeButtonTapped,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      // LikeButton(
                                                      //   isLiked: false,
                                                      //   likeBuilder:
                                                      //       (bool isLiked) {
                                                      //     return Icon(
                                                      //       Icons.favorite,
                                                      //       color: isLiked
                                                      //           ? AppColor
                                                      //               .danger
                                                      //           : Colors.grey,
                                                      //     );
                                                      //   },
                                                      //   likeCount: 6,
                                                      //   onTap:
                                                      //       (onLikeButtonTapped),
                                                      // ),
                                                    ],
                                                  ),

                                                  Divider(
                                                      height: 10.0,
                                                      thickness: 1.0,
                                                      indent: 0.0,
                                                      endIndent: 0.0,
                                                      color: AppColor.grey),

                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 0.0,
                                                        right: 0.0,
                                                        top: 0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 10.0,
                                                                  bottom: 0.0),
                                                          child: Text('评论 2'.tr,
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .active,
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                            top: 0,
                                                            bottom: 0.0),
                                                        child: CircleAvatar(
                                                            radius: 18,
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFCCCCCC),
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                                            ),
                                                      ),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              commentController,
                                                          focusNode:
                                                              commentFocusNode,
                                                          autofocus: true,
                                                          maxLines: 1,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      '写评论',
                                                                  // contentPadding:
                                                                  //     const EdgeInsets.fromLTRB(
                                                                  //         20.0,
                                                                  //         5.0,
                                                                  //         20.0,
                                                                  //         5.0),
                                                                  isDense: true,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .fromLTRB(
                                                                              16,
                                                                              16,
                                                                              0,
                                                                              0),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              32.0),
                                                                      borderSide: const BorderSide(
                                                                          color: AppColor
                                                                              .bluegreen,
                                                                          width:
                                                                              2)),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              32.0))),
                                                        ),
                                                        // flex: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 16),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                                radius: 12,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFCCCCCC),
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                                                ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8)),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "张成翼",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColor
                                                                      .bluegreen,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "过去一年？chatgpt的数据只到2021年某月，请问去年也就是2022年的数据它是从哪儿得到的？",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 0.0,
                                                                  right: 0.0,
                                                                  top: 10.0,
                                                                  bottom: 0.0),
                                                          child: Text(
                                                              "03-06 · 四平校区",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF999999),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 16),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                                radius: 12,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFCCCCCC),
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                                                ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8)),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "陈林海",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColor
                                                                      .bluegreen,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "通信领域很前沿的研究方向，欢迎来林Lab看看",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 0.0,
                                                                  right: 0.0,
                                                                  top: 10.0,
                                                                  bottom: 0.0),
                                                          child: Text(
                                                              "03-02 · 彰武校区",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF999999),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(height: 220),
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
