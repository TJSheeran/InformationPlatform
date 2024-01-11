import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:tongxinbaike/routes/app_routes.dart';
import 'package:tongxinbaike/pages/mytest/head.dart';
// String latitude = '';
// String longitude = '';

class LocatePage extends StatefulWidget {
  @override
  State<LocatePage> createState() => new _LocatePageState();
}

class _LocatePageState extends State<LocatePage> {
  //PopupMenuItem(child: Text("安亭镇"), onTap: () => {_stopLocation(),longitude = '121.21416',latitude = '31.286012'},),
  //     PopupMenuItem(child: Text("南翔镇"), onTap: () => {_stopLocation(),longitude = '121.308228',latitude = '31.291233'},),
  //     PopupMenuItem(child: Text("马陆镇"), onTap: () => {_stopLocation(),longitude = '121.28379',latitude = '31.333048'},),
  //     PopupMenuItem(child: Text("四平路街道（同济）"), onTap: () => {_stopLocation(),longitude = '121.502085',latitude = '31.282588'},),
  //     PopupMenuItem(child: Text("江川路街道（交通大学）"), onTap: () => {_stopLocation(),longitude = '121.436882',latitude = '31.025626'},),
  //       PopupMenuItem(child: Text("五角场街道"), onTap: () => {_stopLocation(),longitude = '121.519728',latitude = '31.30507'},),
  var _cityList = [
    {"location":"安亭镇","long":'121.21416',"lati":'31.286012'},
    {"location":"南翔镇","long":'121.308228',"lati":'31.291233'},
    {"location":"马陆镇","long":'121.28379',"lati":'31.333048'},
    {"location":"四平路","long":'121.502085',"lati":'31.282588'},
    {"location":"江川路","long":'121.436882',"lati":'31.025626'},
    {"location":"五角场","long":'121.519728',"lati":'31.30507'},];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bluegreen,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: const Text('选择定位'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(42.0),
            child: Theme(
              data: Theme.of(context)
                  .copyWith(accentColor: Theme.of(context).accentColor),
              child: Container(
                height: 42,
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 6.0),
                decoration: BoxDecoration(
                    color: Color(0xfff3f4f5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '请输入地理位置',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                        // onChanged: (value) {
                        // },
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //   },
                    //   child: Icon(
                    //     Icons.clear,
                    //     size: 22,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: _cityItem(),
                ),
              )
            ],
          ),
    );
  }
  _cityItem() {
    List<Widget> list = [];
    list.add(Container(
      width: double.infinity,
      height: 40,
      padding: EdgeInsets.only(left: 40, right: 40),
      color: Colors.black.withOpacity(0.1),
      alignment: Alignment.centerLeft,
      child: Text('上海市'),
    ));
    _cityList.forEach((element) => {
      list.add(Container(
        child: Column(
          children: _cityItemList(element),
        ),
      ))
    });
    return list;
  }
  _cityItemList(var element) {
    List<Widget> list = [];
      list.add(GestureDetector(
        onTap: () {
          longitude = element["long"];latitude = element["lati"];
          Get.toNamed(Routes.ROOT,arguments: '${element['location']}');
        },
        child: Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 40, right: 40),
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Text('${element['location']}'),
        ),
      )
    );

    return list;
  }
  // Map<String, Object>? _locationResult;
  //
  // StreamSubscription<Map<String, Object>>? _locationListener;
  //
  // AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
  //   ///
  //   /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
  //   /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
  //   ///
  //   /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
  //   ///
  //   /// [hasContains] 隐私声明中是否包含高德隐私政策说明
  //   ///
  //   /// [hasShow] 隐私权政策是否弹窗展示告知用户
  //   AMapFlutterLocation.updatePrivacyShow(true, true);
  //
  //   /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
  //   ///
  //   /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
  //   ///
  //   /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
  //   ///
  //   /// [hasAgree] 隐私权政策是否已经取得用户同意
  //   AMapFlutterLocation.updatePrivacyAgree(true);
  //
  //   /// 动态申请定位权限
  //   requestPermission();
  //
  //   ///设置Android和iOS的apiKey<br>
  //   ///
  //   /// 定位Flutter插件提供了单独的设置ApiKey的接口，
  //   /// 使用接口的优先级高于通过Native配置ApiKey的优先级（通过Api接口配置后，通过Native配置文件设置的key将不生效），
  //   /// 使用时可根据实际情况决定使用哪种方式
  //   ///
  //   ///key的申请请参考高德开放平台官网说明<br>
  //   ///
  //   ///Android: https://lbs.amap.com/api/android-location-sdk/guide/create-project/get-key
  //   ///
  //   ///iOS: https://lbs.amap.com/api/ios-location-sdk/guide/create-project/get-key
  //   AMapFlutterLocation.setApiKey(
  //       "c09cad058be13e02f148d7e97e3381d0", "df01282b3778d1b79f022fcd9696a2ee");
  //
  //   ///iOS 获取native精度类型
  //   if (Platform.isIOS) {
  //     requestAccuracyAuthorization();
  //   }
  //
  //   ///注册定位结果监听
  //   _locationListener = _locationPlugin
  //       .onLocationChanged()
  //       .listen((Map<String, Object> result) {
  //     setState(() {
  //       _locationResult = result;
  //     });
  //   });
  //
  //   _startLocation();
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   ///移除定位监听
  //   if (_locationListener != null) {
  //     _locationListener!.cancel();
  //   }
  //
  //   ///销毁定位
  //   if (null != _locationPlugin) {
  //     _locationPlugin.destroy();
  //   }
  // }
  //
  // ///设置定位参数
  // void _setLocationOption() {
  //   if (null != _locationPlugin) {
  //     AMapLocationOption locationOption = new AMapLocationOption();
  //
  //     ///是否单次定位
  //     locationOption.onceLocation = false;
  //
  //     ///是否需要返回逆地理信息
  //     locationOption.needAddress = false;
  //
  //     ///逆地理信息的语言类型
  //     locationOption.geoLanguage = GeoLanguage.DEFAULT;
  //
  //     locationOption.desiredLocationAccuracyAuthorizationMode =
  //         AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;
  //
  //     locationOption.fullAccuracyPurposeKey = "AMapLocationScene";
  //
  //     ///设置Android端连续定位的定位间隔
  //     locationOption.locationInterval = 1000;
  //
  //     ///设置Android端的定位模式<br>
  //     ///可选值：<br>
  //     ///<li>[AMapLocationMode.Battery_Saving]</li>
  //     ///<li>[AMapLocationMode.Device_Sensors]</li>
  //     ///<li>[AMapLocationMode.Hight_Accuracy]</li>
  //     locationOption.locationMode = AMapLocationMode.Hight_Accuracy;
  //
  //     ///设置iOS端的定位最小更新距离<br>
  //     locationOption.distanceFilter = 1; //-1;
  //
  //     ///设置iOS端期望的定位精度
  //     /// 可选值：<br>
  //     /// <li>[DesiredAccuracy.Best] 最高精度</li>
  //     /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
  //     /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
  //     /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
  //     /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
  //     locationOption.desiredAccuracy = DesiredAccuracy.BestForNavigation;
  //
  //     ///设置iOS端是否允许系统暂停定位
  //     locationOption.pausesLocationUpdatesAutomatically = false;
  //
  //     ///将定位参数设置给定位插件
  //     _locationPlugin.setLocationOption(locationOption);
  //   }
  // }
  //
  // ///开始定位
  // void _startLocation() {
  //   if (null != _locationPlugin) {
  //     ///开始定位之前设置定位参数
  //     _setLocationOption();
  //     _locationPlugin.startLocation();
  //   }
  // }
  //
  // ///停止定位
  // void _stopLocation() {
  //   if (null != _locationPlugin) {
  //     _locationPlugin.stopLocation();
  //   }
  // }
  //
  // Container _createButtonContainer() {
  //   return new Container(
  //       alignment: Alignment.center,
  //       child: new Row(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           new ElevatedButton(
  //             onPressed: _startLocation,
  //             style: ButtonStyle(
  //               backgroundColor:
  //                   MaterialStateProperty.all<Color>(AppColor.bluegreen),
  //             ),
  //             child: new Text('开始定位'),
  //           ),
  //           new Container(width: 20.0),
  //           new ElevatedButton(
  //             onPressed: _stopLocation,
  //             style: ButtonStyle(
  //               backgroundColor:
  //                   MaterialStateProperty.all<Color>(AppColor.bluegreen),
  //             ),
  //             child: new Text('停止定位'),
  //           ),
  //           new Container(width: 20.0),
  //           new ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor:
  //                   MaterialStateProperty.all<Color>(AppColor.bluegreen),
  //             ),
  //             onPressed: () {
  //               // Navigator.of(context).pop();
  //               Get.toNamed(Routes.ROOT,arguments: "star");
  //             },
  //             child: new Text('返回'),
  //           )
  //         ],
  //       ));
  // }
  //
  // Widget _resultWidget(key, value) {
  //   return new Container(
  //     child: new Row(
  //       children: <Widget>[
  //         new Container(
  //           alignment: Alignment.centerLeft,
  //           width: 100.0,
  //           height: 20.0,
  //           child: new Text(
  //             '$key :',
  //             style: TextStyle(fontSize: 15),
  //           ),
  //         ),
  //         new Container(width: 2.0),
  //         new Container(
  //             alignment: Alignment.centerLeft,
  //             width: 220.0,
  //             height: 20.0,
  //             child: new Text('$value',
  //                 style: TextStyle(fontSize: 14), softWrap: true)),
  //       ],
  //     ),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   List<Widget> widgets = [];
  //   widgets.add(_createButtonContainer());
  //
  //   if (_locationResult != null) {
  //     _locationResult!.forEach((key, value) {
  //       widgets.add(_resultWidget(key, value));
  //
  //       if (key == 'latitude') latitude = '$value';
  //       if (key == 'longitude') longitude = '$value';
  //     });
  //   }
  //
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     //禁止软键盘弹出上顶页面布局
  //     resizeToAvoidBottomInset: false,
  //     body: Center(
  //       child: Center(
  //         child: ListView(
  //           shrinkWrap: true,
  //           padding: const EdgeInsets.only(left: 24.0, right: 24.0),
  //           children: widgets,
  //         ),
  //       ),
  //     ),
  //   );
  //   // new Column(
  //   //       crossAxisAlignment: CrossAxisAlignment.start,
  //   //       mainAxisSize: MainAxisSize.min,
  //   //       children: widgets,
  //   //     );
  // }
  //
  // ///获取iOS native的accuracyAuthorization类型
  // void requestAccuracyAuthorization() async {
  //   AMapAccuracyAuthorization currentAccuracyAuthorization =
  //       await _locationPlugin.getSystemAccuracyAuthorization();
  //   if (currentAccuracyAuthorization ==
  //       AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
  //     print("精确定位类型");
  //   } else if (currentAccuracyAuthorization ==
  //       AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
  //     print("模糊定位类型");
  //   } else {
  //     print("未知定位类型");
  //   }
  // }
  //
  // /// 动态申请定位权限
  // void requestPermission() async {
  //   // 申请权限
  //   bool hasLocationPermission = await requestLocationPermission();
  //   if (hasLocationPermission) {
  //     print("定位权限申请通过");
  //   } else {
  //     print("定位权限申请不通过");
  //   }
  // }
  //
  // /// 申请定位权限
  // /// 授予定位权限返回true， 否则返回false
  // Future<bool> requestLocationPermission() async {
  //   //获取当前的权限
  //   var status = await Permission.location.status;
  //   if (status == PermissionStatus.granted) {
  //     //已经授权
  //     return true;
  //   } else {
  //     //未授权则发起一次申请
  //     status = await Permission.location.request();
  //     if (status == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }
}
