import 'package:get/get.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';

import '../../../routes/app_routes.dart';

class MedicalPage extends StatefulWidget {
  MedicalPage({Key? key}) : super(key: key);

  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  int pagesCount = 4;
  List<String> tabTitle = ['医院', '药店', '报销流程', '校医院'];
  Future<List>? flist;

  Future<List> _ReadHandle(Tabtitle) async {
    var result = await DioUtil().request("/findbaikeFromDemo",
        method: DioMethod.post,
        data: {"category1": "医疗", "category2": Tabtitle, "campus": "嘉定校区"});
    return result;
  }

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
                            // Container(
                            //   margin: EdgeInsets.only(bottom: 14),
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 2),
                            //   decoration: BoxDecoration(
                            //     color: AppColor.bluegreen,
                            //     borderRadius: BorderRadius.only(
                            //       topRight: Radius.circular(10),
                            //       bottomLeft: Radius.circular(10),
                            //       bottomRight: Radius.circular(10),
                            //     ),
                            //   ),
                            //   child: Text(
                            //     '${s[index]["category2"]}', //data.topic}',
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       color: AppColor.active,
                            //     ),
                            //   ),
                            // ),

                            Text(
                              '${s[index]["category2"]}',
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
                                backgroundImage: NetworkImage(
                                    "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
                                ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "TJSheeran",
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
                // Divider(
                //     height: 10.0,
                //     thickness: 1.0,
                //     indent: 5.0,
                //     endIndent: 5.0,
                //     color: Colors.grey),
              ],
            ),
          );
        } //使用_cellForRow回调返回每个cell
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    flist = _ReadHandle(tabTitle[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: flist,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return SafeArea(
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  _pageController.jumpToPage(index);
                                  flist = _ReadHandle(tabTitle[index]);
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: (selectedIndex == index) ? 50 : 0,
                                      width: 5,
                                      color: AppColor.bluegreen,
                                    ),
                                    Expanded(
                                      child: AnimatedContainer(
                                        alignment: Alignment.center,
                                        duration: Duration(milliseconds: 200),
                                        height: 50,
                                        color: (selectedIndex == index)
                                            ? AppColor.bluegreen
                                                .withOpacity(0.2)
                                            : Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 5),
                                          child: Text(
                                            tabTitle[index],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: ((BuildContext context, int index) {
                            return SizedBox(height: 5);
                          }),
                          itemCount: pagesCount),
                    ),
                    Expanded(
                        child: Container(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          if (snapshot.hasData)
                            SizedBox(
                                height: 520,
                                width: 300,
                                child: HeaderWidget(snapshot.data)),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            }));
  }
}
