import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:get/get.dart';
import 'package:demo711/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:demo711/pages/search/search_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo711/routes/app_routes.dart';
class RootPageHead extends StatelessWidget {
  RootPageHead({Key? key}) : super(key: key);

  @override
  SearchController searchController = Get.put(SearchController());
  _searchHandle() async {
    var content = searchController.TextController.text;
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
    DioUtil.getInstance()?.openLog();


  }
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image.asset(
        //   'assets/icons/home_sign.gif',
        //   height: 45,
        // ),
        Expanded(
          child:
          TextFormField(
            controller: searchController.TextController,
            autofocus: false,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: '搜索你想要的',
                contentPadding: const EdgeInsets.fromLTRB(
                    20.0, 15.0, 20.0, 15.0),
              suffixIcon:
                    MaterialButton(
                    minWidth: 20.0,
                    height: 40.0,
                    shape: const StadiumBorder(),
                    onPressed: () {_searchHandle();},
                    color: AppColor.purple,
                    child: const Text(
                      '搜索',
                      style: TextStyle(
                          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: const BorderSide(
                        color: AppColor.purple, width: 2)),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          ),
          flex: 1,
        ),

      ],
    );
  }
}
//   Widget _searchContent() {
//     return Container(
//       height: 30,
//       //搜索栏上下左右边距
//       margin: EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: AppColor.page,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             // padding: EdgeInsets.symmetric(horizontal: 4),
//             padding: EdgeInsets.only(left: 6, right: 2),
//             child: Icon(
//               Icons.search,
//               size: 16,
//               color: AppColor.un3active,
//             ),
//           ),
//           Text(
//             '搜索',
//             )
//         ],
//       ),
//     );
//   }
// }
