import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/view/card/pet_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:dio/dio.dart' as FormDataA;
class SearchPage extends StatefulWidget {
  static String tag = 'Searchpage';
  SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

// Textmaker(News textcon) {
//   final titext = Text(
//     textcon.text!,
//     textAlign: TextAlign.center,
//   );
//   return titext;
// }
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
        if (s[index]['picture'] != null) {
          avator = s[index]['picture'];
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
                          Text(
                            '${s[index]["title"]}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
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
class _SearchPageState extends State<SearchPage> {
  Future<List>? flist;

  Future<List> _ReadHandle() async {
    var formData = FormDataA.FormData.fromMap({
      'baikeSearch': Get.arguments,
    });
    var result = await DioUtil()
             .request("/search", method: DioMethod.post, data: formData);
    return result;
  }
  @override
  void initState(){
    super.initState();
    flist = _ReadHandle();
  }
//   RefreshController _refreshController =
//   RefreshController(initialRefresh: false);
//
//   void _onRefresh() async {
//     // monitor network fetch
//     flist=_ReadHandle();
//     setState(() {});
//     // if failed,use refreshFailed()
//     _refreshController.refreshCompleted();
//   }
//
//   void _onLoading() async {
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//     // if failed,use loadFailed(),if no data return,use LoadNodata()
//     if (mounted) setState(() {});
//     //_refreshController.loadComplete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: floatButton,
//       // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//         body: FutureBuilder(
//             future: flist,
//             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//               if (snapshot.hasData) {
//                 return SmartRefresher(
//                     enablePullDown: true,
//                     enablePullUp: false,
//                     header: WaterDropMaterialHeader(
//                       backgroundColor: AppColor.purple,
//                     ),
//                     controller: _refreshController,
//                     onRefresh: _onRefresh,
//                     onLoading: _onLoading,
//                     child: CustomScrollView(
//                       slivers: <Widget>[
//                         //floatButton,
//                         HeaderWidget(snapshot.data)
//                       ],
//                     ));
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               } else {
//                 return Container(
//                     height: 50,
//                     width: 50,
//                     margin: EdgeInsets.only(left: 210),
//                     child: CircularProgressIndicator(
//                       strokeWidth: 8.0,
//                       color: AppColor.purple,
//                     ));
//               }
//             }));
//   }
// }
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: flist,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return SafeArea(
                  child: Container(
                    child: PageView(
                      children: [
                        if (snapshot.hasData)
                          if(snapshot.data.length!=0)
                          SizedBox(
                              height: 520,
                              width: 300,
                              child: HeaderWidget(snapshot.data))
                        else
              Text(
              "暂时没找到相关内容",
              style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color:Colors.black.withOpacity(0.8),
              ),)
                      ],
                    ),
                  )
              );
            }));
  }
}


