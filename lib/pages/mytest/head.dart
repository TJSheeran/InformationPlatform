import 'package:get/get.dart';
import 'package:demo711/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RootPageHead extends StatelessWidget {
  RootPageHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image.asset(
        //   'assets/icons/home_sign.gif',
        //   height: 45,
        // ),
        Expanded(
          child: TextFormField(
            autofocus: false,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: '搜索你想要的',
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                suffixIcon: MaterialButton(
                  minWidth: 20.0,
                  height: 40.0,
                  shape: const StadiumBorder(),
                  onPressed: () {
                    print("搜索");
                  },
                  color: AppColor.bluegreen,
                  child: const Text(
                    ' 搜  索 ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide:
                        const BorderSide(color: AppColor.bluegreen, width: 2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          flex: 1,
        ),
      ],
    );
  }
}
