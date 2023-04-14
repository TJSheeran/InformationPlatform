import 'package:get/get.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RootPageHead extends StatelessWidget {
  RootPageHead({Key? key}) : super(key: key);
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController()
    ..addListener(() {});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchController,
            focusNode: searchFocusNode,
            autofocus: false,
            maxLines: 1,
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
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide:
                        const BorderSide(color: AppColor.bluegreen, width: 2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          // flex: 1,
        ),
        InkWell(
            onTap: () {
              print("搜索");
            },
            child: Container(
              width: 70,
              height: 38,
              margin: EdgeInsets.only(
                left: 5,
              ),
              decoration: BoxDecoration(
                  color: AppColor.bluegreen,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              alignment: Alignment.center,
              child: Text(
                "搜  索",
                style: TextStyle(
                    color: AppColor.page,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            )),
      ],
    );
  }
}
