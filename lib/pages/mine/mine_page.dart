import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/view/home_pages/comm.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/news.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/view/card/pet_card.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/routes/app_routes.dart';

class MinePage extends StatefulWidget {
  MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

Widget _headerWidget(BuildContext context) {
  return Container(
    color: AppColor.page,
    height: 200,
    child: Container(
      child: Container(
        margin:
            const EdgeInsets.only(top: 100, left: 10, bottom: 20, right: 10),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg"))),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sheeran",
                    style: TextStyle(fontSize: 20, color: AppColor.active),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "学号: 2666666",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      )
                      // Image.asset(name, width: 15),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColor.bluegreen,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    _headerWidget(context),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
