import 'package:get/get.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
class RootPageHead extends StatelessWidget {
  RootPageHead({Key? key}) : super(key: key);
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController()
    ..addListener(() {});

  _searchHandle() async {
    var content = searchController.text;
    if (content == '' ) {
      //记得写弹窗组件！！！commonToast.showToast();
      Fluttertoast.showToast(
          msg: "请输入搜索内容",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    else{
      Get.toNamed(Routes.SEARCH,
          arguments: content);
    }
    //更改登陆发送网址，为了方便测试用的cupcakes，有返回值即可登陆
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchController,
            focusNode: searchFocusNode,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: '输入想搜索的内容',
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
              _searchHandle();
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
