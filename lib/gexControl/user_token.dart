import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
const String tokenKey = "userToken";
const String uidKey = "userUid";
class UserTokenManager{
    static UserTokenManager get instance => UserTokenManager();
    var userToken = "";
    var uid = 0;
    bool get isLogin {
      if (userToken == "") {
        return false;
      } else {
        return true;
      }
    }
    saveUserToken(String tempToken,int tempUid){
      userToken = tempToken;
      SpUtil.putString(tokenKey, tempToken);
      SpUtil.putInt(uidKey, tempUid);
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
    logout(){
      userToken = "";
      SpUtil.remove(tokenKey);
      SpUtil.remove(uidKey);
    }
}