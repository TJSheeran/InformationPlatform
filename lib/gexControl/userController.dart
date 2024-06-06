import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'user_token.dart';
//必须继承GetxController
class UserController extends GetxController {
  //声明的变量后面必须跟.obs.当它变化的时候,使用Obx才能够监听到.
  var token = "".obs;
  var loginState = false.obs;
  var uid = 0.obs;
  logout(){
    loginState.value = false;
    UserTokenManager.instance.logout();
    update();
  }
  login(String tempToken,int tempUid){
    token.value = tempToken;
    uid.value = tempUid;
    loginState.value = true;
    UserTokenManager.instance.saveUserToken(tempToken,tempUid);
    update();
  }
  localUserToken(){
    String? tempToken = UserTokenManager.instance.loadLocalToken();
    int? tempUid = UserTokenManager.instance.loadUid();
    if(tempToken!="")
      {
        token.value = tempToken!;
        loginState.value = true;
        uid.value = tempUid!;
        update();
        //loadNetUserInfo();//登录态验证
      }
  }
  // loadNetUserInfo(){
  //   if(loginState.value==true)
  //     {
  //       //
  //     }
  // }
  @override
  void onInit(){
    super.onInit();
    localUserToken();
  }
}