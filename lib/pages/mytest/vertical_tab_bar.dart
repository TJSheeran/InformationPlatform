import 'package:tongxinbaike/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
class VerticalTabBar extends StatefulWidget {
  VerticalTabBar({Key? key}) : super(key: key);

  @override
  State<VerticalTabBar> createState() => _VerticalTabBarState();
}

class _VerticalTabBarState extends State<VerticalTabBar> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  int pagesCount = 10;

  Future<List>? flist;
  Future<List> _ReadHandle() async {
    var result = await DioUtil().request("/findbaikeFromDemo",
        method: DioMethod.post, data: {"category1": "生活服务", "campus": "嘉定校区"});
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
              color: Colors.white,
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
            Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 14),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          '#${s[index]["category2"]}', //data.topic}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                    ],
                  ),
                  Text(
                    s[index]["content"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                    height: 10.0,
                    thickness: 1.0,
                    indent: 5.0,
                    endIndent: 5.0,
                    color: Colors.grey),
              ],
            ),
          );

          //   Container(
          //   color: Colors.grey,
          //   margin: EdgeInsets.all(10),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         s[index]["category2"],
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontWeight: FontWeight.w800,
          //             fontSize: 8.0,
          //             fontStyle: FontStyle.values[1]),
          //       ),
          //       Text(
          //         s[index]["content"],
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontWeight: FontWeight.w800,
          //             fontSize: 8.0,
          //             fontStyle: FontStyle.values[1]),
          //       ),
          //       Container(
          //         height: 20,
          //       ),
          //     ],
          //   ), //每人一辆跑车
          // );
        } //使用_cellForRow回调返回每个cell
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: flist=_ReadHandle(),
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
                            });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  height: (selectedIndex == index) ? 50 : 0,
                                  width: 5,
                                  color: Colors.blue,
                                ),
                                Expanded(
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: Duration(milliseconds: 500),
                                    height: 50,
                                    color: (selectedIndex == index)
                                        ? Colors.blueGrey.withOpacity(0.2)
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 5),
                                      child: Text('Tab title $index'),
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
                          if(snapshot.hasData)
                            SizedBox(
                                height: 520,
                                width: 300,
                                child:
                                HeaderWidget(snapshot.data)),
                        ],
                      ),

                    ))
              ],
            ),);
        }
      )

    );
  }
}
