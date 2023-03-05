import 'package:demo711/pages/root/root_page_head.dart';
import 'package:demo711/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:demo711/dio_util/news.dart';
import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:demo711/view/card/pet_card.dart';
import 'package:demo711/routes/app_routes.dart';
import 'package:demo711/view/card/pet_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_buttons.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Widget _image({required Offset offset, required double angle}) {
  return Transform.translate(
    offset: offset,
    child: Transform.rotate(
      angle: angle,
      child: SvgPicture.asset(
        "assets/icons/background_liquid.svg",
        width: Get.width * .55,
      ),
    ),
  );}
Widget _title() {
  return Text(
    "  欢迎使用 " ,
    style: Theme.of(Get.context!).textTheme.headline5?.copyWith(
      color: Colors.white,
    ),
  );
}
Widget _subtitle() {
  return Text(
    "    您今天想要干点什么？ ",
    style: TextStyle(
      fontSize: 15,
      color: Colors.grey[200],
    ),
  );
}

List<ImageProvider> list = [
  AssetImage('assets/icons/ori-1.jpg'),
  AssetImage('assets/icons/ori-2.jpg'),
  AssetImage('assets/icons/ori-3.jpg')
];
Widget _imageProfile() {
  return CircleAvatar(
    backgroundImage: AssetImage("assets/icons/logo-gia-developer.png"),
  );
}
class _HomePageState extends State<HomePage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 250,
            color: Colors.blueAccent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _image(offset: Offset(-Get.width * .35, -Get.width * .25), angle: -5),
                _image(offset: Offset(Get.width * .35, Get.width * .25), angle: 4),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _title(),
                          _imageProfile(),
                        ],
                      ),
                      _subtitle(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.blueAccent,
                          ),
                          hintText: "发现新知",
                          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 2)),
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                    )),
                SizedBox(height: 30),
                Container(
                  width: Get.width,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      HomeButtons(),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child:Swiper(
                          autoplay: true,
                          itemBuilder: (BuildContext context,int index){
                            return Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(offset: Offset(1, 1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                                        BoxShadow(offset: Offset(-1, -1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                                        BoxShadow(offset: Offset(-1, 1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                                        BoxShadow(offset: Offset(1, -1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(image: list[index],fit: BoxFit.cover)
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: 3,
                          fade: 0.0,
                          scale: 0.0,
                          curve: Curves.easeInOut,
                          duration: 600,
                          autoplayDelay: 5000,
                          pagination: SwiperPagination(
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: _BottomNavbar(),
    );
  }
}
