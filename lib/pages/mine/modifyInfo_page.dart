import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/routes/app_routes.dart';

class ModifyInfoPage extends StatelessWidget {
  const ModifyInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      // controller: loginController.UsernameController,
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
      // controller: loginController.PasswordController,
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
        print("确认修改");
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
