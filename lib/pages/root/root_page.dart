import 'dart:ui';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/pages/publish/publish_page.dart';
import 'package:tongxinbaike/view/root_pages/message_page.dart';
import 'package:tongxinbaike/pages/mine/mine_page.dart';
import 'package:tongxinbaike/view/root_pages/niceplay_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../config/app_colors.dart';
import '../../view/root_pages/message_page.dart';
import '../../view/root_pages/niceplay_page.dart';
import '../home/home_page.dart';
import '../mine/mine_page.dart';
import '../mine/test_mine_page.dart';
import '../mytest/test_page.dart';
import '../publish/publish_page.dart';
import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tongxinbaike/config/app_colors.dart';


class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}
const Map<String, String> _bottomNames = {
  'home': '首页',
  'niceplay': '发现',
  'create_media': '',
  'message': '消息',
  'mine': '我的',
};


class _RootPageState extends State<RootPage> {

  Map<String, Object>? _rootResult;

  StreamSubscription<Map<String, Object>>? _locationListener;
  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  //当前选中页索引
  int _currentIndex = 0;
  //页面集合
  final List<Widget> _pages = [
    TestPage(),
    NiceplayPage(),
    Container(),
    MessagePage(),
    ProfilePage(),
  ];

  //底部导航数组
  final List<BottomNavigationBarItem> _bottomNavigationBarList = [];




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
    // AMapFlutterLocation.setApiKey(
    //     "anroid ApiKey", "ios ApiKey");

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _rootResult = result;
      });
    });
    _bottomNames.forEach((key, value) {
      _bottomNavigationBarList.add(_bottomNavigationBarItem(key, value));
    });
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
      locationOption.distanceFilter = 1;//-1;

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
  //底部切换
  void _onTabClick(int index) {
    if (index == 2) {
      return _onCreateMedia();
    }

    setState(() {
      _currentIndex = index;
    });
  }

  //点击发布按钮
  void _onCreateMedia() {
    // print('发布活动');
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => PublishPage(),
    //     ),
    //     (route) => false);
    // _startLocation();
    // if (_rootResult != null) {
    //   _rootResult!.forEach((key, value) {
    //     if (key=='latitude')
    //       latitude='$value';
    //     if(key=='longitude')
    //       longitude='$value';
    //   });
    // }
    // _stopLocation();
    showBarModalBottomSheet(
        context: context,
        builder: (context) => PublishPage(),
        enableDrag: true,
        expand: true,
        duration: const Duration(milliseconds: 400),
        backgroundColor: Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
      // 防止floatButton被顶起
      resizeToAvoidBottomInset: false,
      floatingActionButton: _creatMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //发布按钮
  Widget _creatMediaButton() {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.only(top: 45),
      child: FloatingActionButton(
        heroTag: "btnsecond",
        backgroundColor: AppColor.nav,
        child: Image.asset(
          // 'assets/icons/tabbar_post_idle@2x.png',
          'assets/icons/create_media.png',
        ),
        onPressed: _onCreateMedia,
        elevation: 0, //未点击时的阴影
        highlightElevation: 0, //点击时的阴影
      ),
    );
  }

  //底部导航每一项的组件
  BottomNavigationBarItem _bottomNavigationBarItem(String key, String value) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/icons/$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        'assets/icons/${key}_active.png',
        width: 24,
        height: 24,
      ),
      label: value,
    );
  }
}
