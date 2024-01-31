import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/pages/home/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:tongxinbaike/pages/login/login_page.dart';
import '../../dio_util/dio_method.dart';
import '../../dio_util/dio_util.dart';
import 'package:dio/dio.dart' as FormDataA;
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}
class UrlText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextStyle linkStyle;

  UrlText({required this.text, required this.style,required this.linkStyle});

  @override
  Widget build(BuildContext context) {
    // 正则表达式匹配网址
    RegExp exp = RegExp(r'(http|ftp|https)://([\w_-]+(?:\.(?:[\w_-]+))+)([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?');
    // 创建一个文本组件列表
    List<TextSpan> spans = [];
    List<String?> parts = text.split(exp);
    // 遍历每个部分
    for (int i = 0; i < parts.length; i++) {
      String? part = parts[i];
      // 如果不是网址，创建一个普通的文本组件
      if (part != null && part.isNotEmpty) {
        spans.add(TextSpan(
          text: part,
          style: style,
        ));
      }
    }
    // 使用正则表达式匹配文本中的网址
    Iterable<Match> matches = exp.allMatches(text);
    // 遍历每个匹配结果
    for (Match match in matches) {
      // 获取匹配到的网址
      String? url = match.group(0);
      // 创建一个带有点击事件的文本组件
      spans.add(TextSpan(
        text: url,
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            // 使用url_launcher插件打开网址
            if (await canLaunchUrl(Uri.parse(url!))) {
              await launchUrl(Uri.parse(url));
            } else {
              print('Could not launch $url');
            }
          },
      ));
    }
    // 将文本分割成网址和非网址的部分
    // 返回一个富文本组件，包含所有的文本组件列表
    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }
}
class _DetailPageState extends State<DetailPage> {
  DetailController detailController = Get.find<DetailController>();
  bool isSubscribed = false;
  bool dataisLiked = false;
  bool isDisLiked = false;
  bool isCollected = false;
  int tieziuid = 0;
  int likeCount = 0;
  var listup = [];
  var listbool = [];
  String author = "TJSheeran";
  String avatar =
      "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg";
  String createtime = "2023-03-03 18:36:36";
  FocusNode commentFocusNode = FocusNode();
  TextEditingController commentController = TextEditingController()
    ..addListener(() {});

  Future subscribed() async {
    setState(() {
      this.isSubscribed = !isSubscribed;
    });
    // if (isSubscribed) {
    //     var result = await DioUtil().request("/follow",
    //         method: DioMethod.post,
    //         data: {"userid": uid, "tieziid": Get.arguments['id']});
    //     if (result["info"] == "关注成功")
    //       Fluttertoast.showToast(
    //           msg: "关注成功",
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.CENTER,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.black45,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    // }
    // else{
    //   var result = await DioUtil().request("/delectfollow",
    //       method: DioMethod.post,
    //       data: {"userid": uid, "tieziid": Get.arguments['id']});
    //   Fluttertoast.showToast(
    //       msg: "取消关注成功",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.black45,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
    if (isSubscribed) {
        var formData = FormDataA.FormData.fromMap({
          "userid": uid, "tieziid": Get.arguments['id']
        });
        var result = await DioUtil()
          .request("/follow", method: DioMethod.post, data: formData);
        if (result["info"] == "关注成功")
          Fluttertoast.showToast(
              msg: "关注成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
    }
    else{
      var formData = FormDataA.FormData.fromMap({
        "userid": uid, "tieziid": Get.arguments['id']
      });
      var result = await DioUtil()
          .request("/delectfollow", method: DioMethod.post, data: formData);
      Fluttertoast.showToast(
          msg: "取消关注成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget HeaderWidget(List s) {
    return ListView.builder(
        itemCount: s.length, //告诉ListView总共有多少个cell
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 0),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
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
                        NetworkImage(s[index]['commnetauthorpic'])//NetworkImage(avatar) //data.userImgUrl),
                        ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      child: Text(
                        s[index]['author'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColor.bluegreen,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    LikeButton(
                      isLiked:
                      listbool[index],
                      likeBuilder:
                          (isLiked) {
                        return Icon(
                          isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
                          color: isLiked ? AppColor.danger : Colors.grey,
                        );
                      },
                      likeCount:
                      listup[index],
                      onTap:
                          (isLiked) {
                        return  onLikeCommentTapped(
                          isLiked,index,s[index]['id']
                        );
                      },
                    ),
                  ],

                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  s[index]['content'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 10.0, bottom: 0.0),
                  child: Text('嘉定校区',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF999999),
                      )),
                ),
              ],
            ),
          );
        } //使用_cellForRow回调返回每个cell
        );
  }
  Future _delete() async {
    var result = await DioUtil().request("/disableBaike/"+Get.arguments['id'].toString(),
        method: DioMethod.delete,
        data: {});
    // var result = Tabtitle=="全部"?await DioUtil().request("/findbaikeFromDemo",
    //     method: DioMethod.post,
    //     data: {"category1": "美食休闲", "campus": longitude+','+latitude})
    //     :await DioUtil().request("/findbaikeFromDemo",
    //     method: DioMethod.post,
    //     data: {"category1": "美食休闲", "category2": Tabtitle, "campus": longitude+','+latitude});
    return result;
  }
  Future<bool> onLikeCommentTapped(bool isLiked,int index, int commentid) async {
    setState(() {
      listbool[index] = !isLiked;
      listup[index] = listbool[index]
          ? listbool[index]
          ? listup[index] + 1
          : listup[index]
          : listbool[index]
          ? listup[index]
          : listup[index] - 1;
    });
    if (!isLiked) {
      var formData = FormDataA.FormData.fromMap({
        "commentid": commentid.toString(),"userid": uid
      });
      var result = await DioUtil()
          .request("/likecomment", method: DioMethod.post, data: formData);
      if (result["info"] == "点赞成功")
        Fluttertoast.showToast(
            msg: "点赞成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
    } else {
      var formData = FormDataA.FormData.fromMap({
        "commentid": commentid.toString(),"userid": uid
      });
      var result = await DioUtil()
          .request("/dellikecomment", method: DioMethod.post, data: formData);
      if (result["info"] == "点赞已取消")
        Fluttertoast.showToast(
            msg: "点赞已取消",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
    }
    return listbool[index];
  }
  //点赞
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
    if (!isLiked) {
      var result = await DioUtil().request("/addlike",
          method: DioMethod.post,
          data: {"userid": uid, "tieziid": Get.arguments['id']});
      if (result["info"] == "点赞成功")
        Fluttertoast.showToast(
            msg: "点赞成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
    } else {
      var result = await DioUtil().request("/delectlike",
          method: DioMethod.post,
          data: {"userid": uid, "tieziid": Get.arguments['id']});
      if (result["info"] == "点赞已取消")
        Fluttertoast.showToast(
            msg: "点赞已取消",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
    }

    return dataisLiked;
  }

  // Future<bool> onLikeButtonTapped(bool isLiked) async {
  //   if (!isLiked) {
  //     var result = await DioUtil().request("/addlike",
  //         method: DioMethod.post,
  //         data: {"userid": uid, "tieziid": Get.arguments['id']});
  //     if(result["info"]=="点赞成功")
  //       Fluttertoast.showToast(
  //           msg: "点赞成功",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black45,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //   }
  //   else{
  //     var result = await DioUtil().request("/delectlike",
  //         method: DioMethod.post,
  //         data: {"userid": uid, "tieziid": Get.arguments['id']});
  //     if(result["info"]=="点赞已取消")
  //       Fluttertoast.showToast(
  //           msg: "点赞已取消",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black45,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //   }
  //   return !isLiked;
  // }
  // Future<bool> onDisLikeButtonTapped(bool isLiked) async {
  //   if (!isLiked) {
  //       Fluttertoast.showToast(
  //           msg: "点赞成功",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black45,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //   }
  //   else{
  //       Fluttertoast.showToast(
  //           msg: "点赞已取消",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black45,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //   }
  //   return !isLiked;
  // }
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
    // setState(() {
    //   isCollected = !isLiked;
    // });
    if (!isLiked) {
      var result = await DioUtil().request("/addcollect",
          method: DioMethod.post,
          data: {"userid": uid, "tieziid": Get.arguments['id']});
      if (result["info"] == "收藏成功")
        Fluttertoast.showToast(
            msg: "收藏成功，到收藏夹里看看吧",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
    } else {
      var result = await DioUtil().request("/delectcollect",
          method: DioMethod.post,
          data: {"userid": uid, "tieziid": Get.arguments['id']});
      if (result["info"] == "收藏已取消")
        Fluttertoast.showToast(
            msg: "收藏已取消",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
    }

    return !isLiked;
  }

  Future<List>? likeinfor;

  Future<List> _ReadHandle() async {
    var result = await DioUtil().request("/searchAll",
        method: DioMethod.post,
        data: {"userid": uid, "tieziid": Get.arguments['id']});
    isSubscribed = result[0]["isfollowed"];
    dataisLiked = result[0]["isliked"];
    isDisLiked = result[0]["ishated"];
    likeCount = result[0]["likenum"];
    result[0]["commentList"].forEach((x){
      listup.add(x['likecount']);
      listbool.add(x['islike']== 0 ? false : true);
    });
    //data: {"userid": 1, "tieziid": 1});
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    likeinfor = _ReadHandle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //arguments传参
    Map s = Get.arguments;
    if (s['author'] != null) {
      this.author = s['author'];
    }
    if (s['userpic'] != null) {
      this.avatar = s['userpic'];
    }
    if (s['createtime'] != null) {
      this.createtime = s['createtime'];
    }
    if (s['uid'] != null) {
      this.tieziuid = s['uid'];
    }

    return FutureBuilder(
        future: likeinfor,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                              child: Container(
                                  // color: CupertinoTheme.of(context)
                                  //     .scaffoldBackgroundColor
                                  //     .withOpacity(0.1),
                                  // color: Colors.white.withOpacity(0.1),
                                  child: Stack(
                                children: [
                                  if (snapshot.hasData)
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
                                              padding:
                                                  EdgeInsets.only(bottom: 40),
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 0.0,
                                                                    right: 0.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          0.0,
                                                                      top: 15.0,
                                                                      bottom:
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        SelectableText(
                                                                      '${s["title"]}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              10.0,
                                                                          right:
                                                                              0.0,
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              0.0),
                                                                      child: Text(
                                                                          s[
                                                                              "category1"],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Color(0xFF999999),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              3.0,
                                                                          right:
                                                                              3.0,
                                                                          top:
                                                                              10.0,
                                                                          bottom:
                                                                              0.0),
                                                                      child: Text(
                                                                          "·",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Color(0xFF999999),
                                                                          )),
                                                                    ),
                                                                    // Container(
                                                                    //   margin: EdgeInsets.only(
                                                                    //       left:
                                                                    //           0.0,
                                                                    //       right:
                                                                    //           0.0,
                                                                    //       top:
                                                                    //           10.0,
                                                                    //       bottom:
                                                                    //           0.0),
                                                                    //   child: Text(
                                                                    //       s[
                                                                    //           "category2"],
                                                                    //       style:
                                                                    //           TextStyle(
                                                                    //         fontSize:
                                                                    //             15,
                                                                    //         color:
                                                                    //             Color(0xFF999999),
                                                                    //       )),
                                                                    // ),
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
                                                              color: AppColor
                                                                  .grey),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 0.0,
                                                                    right: 0.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              10.0,
                                                                          right:
                                                                              10.0,
                                                                          top:
                                                                              15.0,
                                                                          bottom:
                                                                              0.0),
                                                                      child: CircleAvatar(
                                                                          radius:
                                                                              22,
                                                                          backgroundColor: Color(
                                                                              0xFFCCCCCC),
                                                                          backgroundImage:
                                                                              NetworkImage(avatar) //data.userImgUrl),
                                                                          ),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Text(
                                                                          author,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                AppColor.bluegreen,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 2)),
                                                                        // Text(
                                                                        //   s["campus"],
                                                                        //   //data.description,
                                                                        //   style:
                                                                        //       TextStyle(
                                                                        //     fontSize:
                                                                        //         15,
                                                                        //     color:
                                                                        //         Color(0xFF999999),
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                // SizedBox(
                                                                //   width: 130,
                                                                // ),
                                                                Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        subscribed();
                                                                      },
                                                                      child: isSubscribed
                                                                          ? Container(
                                                                              width: 80,
                                                                              height: 35,
                                                                              margin: EdgeInsets.only(left: 10, top: 15),
                                                                              decoration: BoxDecoration(color: AppColor.bluegreen, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "已关注",
                                                                                style: TextStyle(color: AppColor.page, fontSize: 15, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              width: 80,
                                                                              height: 35,
                                                                              margin: EdgeInsets.only(left: 10, top: 15),
                                                                              decoration: BoxDecoration(color: AppColor.bluegreen.withOpacity(0.2), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "+ 关 注",
                                                                                style: TextStyle(color: AppColor.bluegreen, fontSize: 15, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 3,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 6,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10.0,
                                                                    right: 0.0,
                                                                    top: 10.0,
                                                                    bottom:
                                                                        0.0),
                                                            child: Text(
                                                                likeCount
                                                                        .toString() +
                                                                    "人赞同了该回答",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xFF999999),
                                                                )),
                                                          ),
                                                          SizedBox(height: 16),
                                                          Container(
                                                              width: 340,
                                                              // height: 180,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 0,
                                                                      top: 0,
                                                                      right: 15,
                                                                      bottom:
                                                                          10),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      AppColor
                                                                          .page,
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5.0))),
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child:
                                                              UrlText(
                                                                text: s["content"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    18,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.8)),
                                                                linkStyle: TextStyle(
                                                                    fontSize:
                                                                    18,
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                        0.8)),
                                                              ),),
                                                              //     SelectableText(
                                                              //   s["content"],
                                                              //   style: TextStyle(
                                                              //       fontSize:
                                                              //           18,
                                                              //       color: Colors
                                                              //           .black
                                                              //           .withOpacity(
                                                              //               0.8)),
                                                              // )),
                                                          Visibility(
                                                              visible:
                                                                  s["baikePic"] !=
                                                                      null,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(),
                                                                  Container(
                                                                    width: 260,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Image.network(s["picture"] !=
                                                                            null
                                                                        ? s["picture"]
                                                                        : ""),
                                                                  ),
                                                                  SizedBox(),
                                                                ],
                                                              )),
                                                          SizedBox(height: 15),
                                                          if(snapshot.data[0]['commentList'].isNotEmpty)
                                                          Container(
                                                            constraints: new BoxConstraints.expand(
                                                              height: 100.0,
                                                            ),
                                                            decoration: new BoxDecoration(
                                                              border: new Border.all(width: 2.0, color: AppColor.bluegreen),
                                                              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                                                            ),
                                                            padding: const EdgeInsets.all(8.0),
                                                            alignment: Alignment.topLeft,
                                                            child:Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(Icons.child_care,
                                                                    color: AppColor.bluegreen,),
                                                                  new Text('智能AI助手帮您整理了回答：',style: TextStyle(
                                                                    fontFamily: 'Roboto',
                                                                    fontSize: 16.0,
                                                                    color: AppColor.bluegreen,
                                                                  ),)
                                                                ],
                                                              ),
                                                              UrlText(
                                                                text: snapshot.data[0]["airesult"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    15,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.8)),
                                                                linkStyle: TextStyle(
                                                                    fontSize:
                                                                    18,
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                        0.8)),
                                                              ),
                                                            ])
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0,
                                                                        right:
                                                                            0.0,
                                                                        top:
                                                                            10.0,
                                                                        bottom:
                                                                            0.0),
                                                                child: Text(
                                                                    "发布于 " +
                                                                        createtime,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xFF999999),
                                                                    )),
                                                              ),
                                                              // if (tieziuid == uid)
                                                              // Container(
                                                              //   margin: EdgeInsets
                                                              //       .only(
                                                              //       left:
                                                              //       10.0,
                                                              //       right:
                                                              //       0.0,
                                                              //       top:
                                                              //       10.0,
                                                              //       bottom:
                                                              //       0.0),
                                                              //   child: TextButton(
                                                              //     onPressed: (){_delete();},
                                                              //     child:
                                                              //       const Text("删除",
                                                              //       style:
                                                              //       TextStyle(
                                                              //         fontSize:
                                                              //         15,
                                                              //         color: Color(
                                                              //             0xFF999999),
                                                              //       )))
                                                              // ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0,
                                                                        right:
                                                                            0.0,
                                                                        top:
                                                                            10.0,
                                                                        bottom:
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        LikeButton(
                                                                          isLiked:
                                                                              snapshot.data[0]["iscollected"],
                                                                          likeBuilder:
                                                                              (isLiked) {
                                                                            return Icon(
                                                                              isLiked ? Icons.star_rounded : Icons.star_border_rounded,
                                                                              color: isLiked ? AppColor.warning : Colors.grey,
                                                                              size: 30,
                                                                            );
                                                                          },
                                                                          // likeCount: 8,
                                                                          onTap:
                                                                              onCollectButtonTapped,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              14,
                                                                        ),
                                                                        LikeButton(
                                                                          isLiked:
                                                                              dataisLiked,
                                                                          likeBuilder:
                                                                              (isLiked) {
                                                                            return Icon(
                                                                              isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
                                                                              color: isLiked ? AppColor.danger : Colors.grey,
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
                                                                              isLiked ? Icons.thumb_down_alt_rounded : Icons.thumb_down_alt_outlined,
                                                                              color: isLiked ? AppColor.info : Colors.grey,
                                                                            );
                                                                          },
                                                                          // likeCount: 8,
                                                                          onTap:
                                                                              onDisLikeButtonTapped,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 3,
                                                                    )
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
                                                              color: AppColor
                                                                  .grey),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 0.0,
                                                                    right: 0.0,
                                                                    top: 0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0,
                                                                      top: 10.0,
                                                                      bottom:
                                                                          0.0),
                                                                  child: Text(
                                                                      '评论'.tr,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColor
                                                                            .active,
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0,
                                                                        right:
                                                                            10.0,
                                                                        top: 0,
                                                                        bottom:
                                                                            0.0),
                                                                child: CircleAvatar(
                                                                    radius: 18,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFFCCCCCC),
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            avatar) //data.userImgUrl),
                                                                    ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      commentController,
                                                                  focusNode:
                                                                      commentFocusNode,
                                                                  autofocus:
                                                                      false,
                                                                  maxLines: 1,
                                                                  onFieldSubmitted:
                                                                      (value) {
                                                                    DioUtil().request(
                                                                        "/add_comment",
                                                                        method:
                                                                            DioMethod.post,
                                                                        data: {
                                                                          'uid':
                                                                              uid,
                                                                          "tieziid":
                                                                              Get.arguments['id'],
                                                                          'content':
                                                                              // commentController.text
                                                                              value
                                                                        });
                                                                    //setState(() {_ReadHandle();});
                                                                    Fluttertoast.showToast(
                                                                        msg:
                                                                            "评论成功",
                                                                        toastLength:
                                                                            Toast
                                                                                .LENGTH_SHORT,
                                                                        gravity:
                                                                            ToastGravity
                                                                                .BOTTOM,
                                                                        timeInSecForIosWeb:
                                                                            1,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .black45,
                                                                        textColor:
                                                                            Colors
                                                                                .white,
                                                                        fontSize:
                                                                            16.0);
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      hintText: '写评论',
                                                                      // contentPadding:
                                                                      //     const EdgeInsets.fromLTRB(
                                                                      //         20.0,
                                                                      //         5.0,
                                                                      //         20.0,
                                                                      //         5.0),
                                                                      isDense: true,
                                                                      contentPadding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: AppColor.bluegreen, width: 2)),
                                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                              height: 550,
                                                              width: 600,
                                                              child: HeaderWidget(
                                                                  snapshot.data[
                                                                          0][
                                                                      'commentList'])),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )))
                                ],
                              )))))));
        });
  }
}
