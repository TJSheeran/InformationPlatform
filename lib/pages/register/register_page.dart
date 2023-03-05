import 'dart:convert';
import 'package:demo711/config/app_colors.dart';
import 'package:demo711/pages/register/register_controller.dart';
import 'package:demo711/pages/register/register_page.dart';
import 'package:demo711/pages/root/root_page.dart';
import 'package:demo711/routes/app_routes.dart';
import 'package:demo711/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:demo711/dio_util/news.dart';
import 'package:dio/dio.dart';
import 'package:demo711/dio_util/dio_method.dart';
import 'package:demo711/dio_util/dio_util.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = Get.find<RegisterController>();

  _registerHandle() async {
    var name = registerController.UsernameController.text;
    var password = registerController.PasswordController.text;
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
        await DioUtil().request("/register", method: DioMethod.post, data: {
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
    if (result['info'] == '注册成功') {
      Get.toNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    //注册标题
    final registertext = Text(
      "注册",
      style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 35,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );

    //username输入框
    final username = TextFormField(
      controller: registerController.UsernameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: '账号',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //password输入框
    final password = TextFormField(
      controller: registerController.PasswordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '密码',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //注册按钮
    final registerButton = MaterialButton(
      minWidth: 10.0,
      height: 60.0,
      shape: const StadiumBorder(),
      onPressed: () {
        _registerHandle();
      },
      color: Colors.blueAccent,
      child: const Text(
        '注 册',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    //新用户注册提醒行
    const fronttext = Text(
      "请您阅读",
      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
      textAlign: TextAlign.center,
    );
    final register = TextButton(
      onPressed: () {},
      child: const Text(
        '用户条例政策',
        style: TextStyle(color:Colors.blueAccent, fontSize: 18),
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
              registertext,
              const SizedBox(height: 24.0),
              username,
              const SizedBox(
                height: 12.0,
              ),
              password,
              const SizedBox(
                height: 12.0,
              ),
              registerButton,
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
