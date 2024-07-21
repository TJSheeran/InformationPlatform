import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'user_token.dart';
//必须继承GetxController
class UserController extends GetxController {
  //声明的变量后面必须跟.obs.当它变化的时候,使用Obx才能够监听到.
  var token = "".obs;
  var loginState = false.obs;
  var uid = 0.obs;
  var isAdmin = false.obs;
  logout(){
    loginState.value = false;
    UserTokenManager.instance.logout();
    update();
  }
  login(String tempToken,int tempUid,bool tempAdmin){
    token.value = tempToken;
    uid.value = tempUid;
    loginState.value = true;
    isAdmin.value = tempAdmin;
    UserTokenManager.instance.saveUserToken(tempToken,tempUid,tempAdmin);
    update();
  }
  localUserToken(){
    String? tempToken = UserTokenManager.instance.loadLocalToken();
    int? tempUid = UserTokenManager.instance.loadUid();
    bool? tempAdmin = UserTokenManager.instance.loadAdmin();
    if(tempToken!="")
      {
        token.value = tempToken!;
        loginState.value = true;
        uid.value = tempUid!;
        isAdmin.value = tempAdmin!;
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