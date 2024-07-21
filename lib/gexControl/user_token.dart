
import 'package:sp_util/sp_util.dart';

const String tokenKey = "userToken";
const String uidKey = "userUid";
const String adminKey = "userAdmin";

class UserTokenManager{
    static UserTokenManager get instance => UserTokenManager();
    var userToken = "";
    var uid = 0;
    var isAdmin = false;
    bool get isLogin {
      if (userToken == "") {
        return false;
      } else {
        return true;
      }
    }
    saveUserToken(String tempToken,int tempUid,bool tempAdmin){
      userToken = tempToken;
      SpUtil.putString(tokenKey, tempToken);
      SpUtil.putInt(uidKey, tempUid);
      SpUtil.putBool(adminKey, tempAdmin);
      // print( SpUtil.getInt(uidKey,defValue: 0));
      // print( SpUtil.haveKey(tokenKey));
      // print(tempToken);
    }
    String?loadLocalToken(){
      String? entity = SpUtil.getString(tokenKey,defValue: "");
      userToken = entity!;
      return entity;
    }
    int?loadUid(){
      int?entity = SpUtil.getInt(uidKey,defValue: 0);
      uid = entity!;
      return entity;
    }
    bool?loadAdmin(){
      bool?entity = SpUtil.getBool(adminKey,defValue: false);
      isAdmin = entity!;
      return entity;
    }
    logout(){
      userToken = "";
      SpUtil.remove(tokenKey);
      SpUtil.remove(uidKey);
      SpUtil.remove(adminKey);

    }
}