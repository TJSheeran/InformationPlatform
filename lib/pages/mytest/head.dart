import 'package:get/get.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:tongxinbaike/pages/home/custom_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tongxinbaike/pages/mytest/locate_test.dart';
import 'dart:async';
import 'dart:io';
import 'test_page.dart';

String latitude = '';
String longitude = '';

class RootPageHead extends StatefulWidget {
  @override
  State<RootPageHead> createState() => new _RootPageHeadState();
}

class _RootPageHeadState extends State<RootPageHead> {
  Map<String, Object>? _locationResult;

  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController()
    ..addListener(() {});

  StreamSubscription<Map<String, Object>>? _locationListener;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  @override
  void initState() {
    super.initState();

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    requestPermission();

    ///设置Android和iOS的apiKey<br>
    ///
    /// 定位Flutter插件提供了单独的设置ApiKey的接口，
    /// 使用接口的优先级高于通过Native配置ApiKey的优先级（通过Api接口配置后，通过Native配置文件设置的key将不生效），
    /// 使用时可根据实际情况决定使用哪种方式
    ///
    ///key的申请请参考高德开放平台官网说明<br>
    ///
    ///Android: https://lbs.amap.com/api/android-location-sdk/guide/create-project/get-key
    ///
    ///iOS: https://lbs.amap.com/api/ios-location-sdk/guide/create-project/get-key
    AMapFlutterLocation.setApiKey(
        "c09cad058be13e02f148d7e97e3381d0", "df01282b3778d1b79f022fcd9696a2ee");

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _locationResult = result;
      });
    });

    Get.arguments==null?_startLocation():_stopLocation();
  }

  Future<String> _locatehandle() async {
    var result = await DioUtil().request(
      "/getAddress/"+longitude+','+latitude,
      method: DioMethod.get,
      //data: {'uid': '1'},
    );
    // List<Mes> act=[];
    // act.add(Mes("用户名","回复时间","回复内容",1,"原帖内容"));
    return result;
  }

  _searchHandle() async {
    var content = searchController.text;
    if (content == '') {
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
    } else {
      Get.toNamed(Routes.SEARCH, arguments: content);
    }
    //更改登陆发送网址，为了方便测试用的cupcakes，有返回值即可登陆
  }

  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    if (_locationListener != null) {
      _locationListener!.cancel();
    }

    ///销毁定位
    if (null != _locationPlugin) {
      _locationPlugin.destroy();
    }
  }

  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = false;

      ///是否需要返回逆地理信息
      locationOption.needAddress = false;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 1000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = 1; //-1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.BestForNavigation;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  ///停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }
  Widget iconButton(Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Icon(
            FontAwesomeIcons.locationDot,
            size: 28,
            color: color,
          ),
        ),
        onTap: () {
          //_Locate();
          //Get.toNamed(Routes.LOCATE);
        },
        highlightColor: color.withOpacity(.1),
        overlayColor: MaterialStateProperty.all(
          color.withOpacity(.3),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var title = Get.arguments;
    if(title == null)
    {
    if (_locationResult != null) {
      _locationResult!.forEach((key, value) {
        if (key == 'latitude') latitude = '$value';
        if (key == 'longitude') longitude = '$value';
      });
    }}
    return Row(
      children: [
        TextButton(onPressed:() {Get.toNamed(Routes.LOCATE);},
          child: Row (
              children: [
                FutureBuilder<String>(
                  future: _locatehandle(), // 假设这是一个异步方法，返回一个Future<String>
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return
                        Text(snapshot.data!,
                      style: TextStyle(
                        color: AppColor.bluegreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w600));// 数据加载完成，显示数据或错误信息
                    } else {
                      return Text("定位",
                          style: TextStyle(
                              color: AppColor.bluegreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)); // 数据加载中，显示进度指示器
                    }
                  },
                ),
              //   Text(title?.isNotEmpty ?? false?title:"定位",
              // style: TextStyle(
              //   color: AppColor.bluegreen,
              //   fontSize: 16,
              //   fontWeight: FontWeight.w600)),
          Icon(
          FontAwesomeIcons.locationDot,
            size: 18,
            color: AppColor.bluegreen,
          ),]
        ),),
    // Icon(
    // FontAwesomeIcons.locationDot,
    //   size: 20,
    //   color: AppColor.bluegreen,
    // ),
    //     PopupMenuButton(
    //       icon:           Icon(
    // FontAwesomeIcons.locationDot,
    //   size: 28,
    //   color: AppColor.bluegreen,
    // ),
    //     itemBuilder: (BuildContext context){
    //   return [
    //     PopupMenuItem(child: Text("安亭镇"), onTap: () => {_stopLocation(),longitude = '121.21416',latitude = '31.286012'},),
    //     PopupMenuItem(child: Text("南翔镇"), onTap: () => {_stopLocation(),longitude = '121.308228',latitude = '31.291233'},),
    //     PopupMenuItem(child: Text("马陆镇"), onTap: () => {_stopLocation(),longitude = '121.28379',latitude = '31.333048'},),
    //     PopupMenuItem(child: Text("四平路街道（同济）"), onTap: () => {_stopLocation(),longitude = '121.502085',latitude = '31.282588'},),
    //     PopupMenuItem(child: Text("江川路街道（交通大学）"), onTap: () => {_stopLocation(),longitude = '121.436882',latitude = '31.025626'},),
    //       PopupMenuItem(child: Text("五角场街道"), onTap: () => {_stopLocation(),longitude = '121.519728',latitude = '31.30507'},),
    //     PopupMenuItem(child: Text("使用手机定位"), onTap: () => _startLocation(),),
    //   ];
    // },
    // ),
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
              //_startLocation();
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

  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future _Locate() async {
    var result = await DioUtil().request(
        "https://restapi.amap.com/v3/ip?key=e4a914953bb737f6ffc15b9c1b319cdd",
        method: DioMethod.get);
    Fluttertoast.showToast(
        msg: "当前位置为" + result["province"] + "," + result["city"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
    return result;
  }
}



  // RootPageHead({Key? key}) : super(key: key);




