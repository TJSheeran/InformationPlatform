import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/app_colors.dart';
import '../../dio_util/dio_method.dart';
import '../../dio_util/dio_util.dart';
import '../../routes/app_routes.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //注入login_controller页面控制文件
  LoginController loginController = Get.find<LoginController>();

  _loginHandle() async {
    var name = loginController.UsernameController.text;
    var password = loginController.PasswordController.text;
    if (name == '' || password == '') {
      //记得写弹窗组件！！！commonToast.showToast();
      Fluttertoast.showToast(
          msg: "请输入用户名和密码",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    //更改登陆发送网址，为了方便测试用的cupcakes，有返回值即可登陆
    DioUtil.getInstance()?.openLog();

    var result =
        await DioUtil().request("/login", method: DioMethod.post, data: {
      'username': name,
      'password': password,
    });
    Fluttertoast.showToast(
        msg: result['info'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
    if (result['info'] == '登录成功') {
      Get.toNamed(Routes.ROOT);
    }
  }

  @override
  Widget build(BuildContext context) {
    //登录标题
    final logintext = Text(
      "登  录",
      style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 35,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );

    //username输入框
    final username = TextFormField(
      controller: loginController.UsernameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: '账号',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide:
                  const BorderSide(color: AppColor.bluegreen, width: 2)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //password输入框
    final password = TextFormField(
      controller: loginController.PasswordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '密码',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide:
                  const BorderSide(color: AppColor.bluegreen, width: 2)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //登录按钮
    final loginButton = MaterialButton(
      minWidth: 10.0,
      height: 60.0,
      shape: const StadiumBorder(),
      onPressed: () {
        _loginHandle();
      },
      color: AppColor.bluegreen,
      child: const Text(
        '登 录',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    //新用户注册提醒行
    const fronttext = Text(
      "新用户？",
      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
      textAlign: TextAlign.center,
    );
    final register = TextButton(
      onPressed: () {
        Get.toNamed(Routes.REGISTER);
      },
      child: const Text(
        '注册',
        style: TextStyle(color: AppColor.bluegreen, fontSize: 18),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      //禁止软键盘弹出上顶页面布局
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logintext,
              const SizedBox(height: 24.0),
              username,
              const SizedBox(
                height: 12.0,
              ),
              password,
              const SizedBox(
                height: 12.0,
              ),
              loginButton,
              const SizedBox(
                height: 36.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  fronttext,
                  register,
                ],
              ),
              const SizedBox(
                height: 180.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
