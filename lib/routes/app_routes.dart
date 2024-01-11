import 'package:tongxinbaike/pages/home/detail_binding.dart';
import 'package:tongxinbaike/pages/home/detail_page.dart';
import 'package:tongxinbaike/pages/home/home_binding.dart';
import 'package:tongxinbaike/pages/home/home_page.dart';
import 'package:tongxinbaike/pages/login/login_page.dart';
import 'package:tongxinbaike/pages/mine/mine_binding.dart';
import 'package:tongxinbaike/pages/mine/mine_page.dart';
import 'package:tongxinbaike/pages/mine/modifyInfo_binding.dart';
import 'package:tongxinbaike/pages/mytest/test_binding.dart';
import 'package:tongxinbaike/pages/mytest/test_page.dart';
import 'package:tongxinbaike/pages/publish/publish_binding.dart';
import 'package:tongxinbaike/pages/publish/publish_page.dart';
import 'package:tongxinbaike/pages/register/register_binding.dart';
import 'package:tongxinbaike/pages/register/register_page.dart';
import 'package:tongxinbaike/pages/root/root_binding.dart';
import 'package:tongxinbaike/pages/root/root_page.dart';
import 'package:tongxinbaike/pages/splash/splash_binding.dart';
import 'package:tongxinbaike/pages/splash/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
//import '../pages/login/login_page_old.dart';
import '../pages/login/login_binding.dart';
import '../pages/mine/modifyInfo_page.dart';
import '../pages/search/search_binding.dart';
import '../pages/search/search_page.dart';
import 'package:tongxinbaike/pages/home/classify_page.dart';
import 'package:tongxinbaike/pages/mytest/locate_test.dart';
import 'package:tongxinbaike/pages/mytest/head.dart';
abstract class AppPages {
  static final pages = [
    //闪屏页
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),

    //登录页
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),

    //主页
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),

    //Root页
    GetPage(name: Routes.ROOT, page: () => RootPage(), binding: RootBinding()),

    //Publish页
    GetPage(
        name: Routes.PUBLISH,
        page: () => PublishPage(),
        binding: PublishBinding()),
    GetPage(
      name: Routes.CLASSIFY,
      page: () => ClassifyPage(),
    ),

    //个人主页
    GetPage(name: Routes.MINE, page: () => MinePage(), binding: MineBinding()),

    //主页详情页
    GetPage(
        name: Routes.DETAIL,
        page: () => DetailPage(),
        binding: DetailBinding()),

    //主页详情页
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),

    GetPage(
        name: Routes.SEARCH,
        page: () => SearchPage(),
        binding: SearchBinding()),

    GetPage(name: Routes.TEST, page: () => TestPage(), binding: TestBinding()),

    GetPage(name: Routes.LOCATE, page: () => LocatePage()),
    GetPage(name: Routes.HEAD, page: () =>  RootPageHead()),
    GetPage(
        name: Routes.MODIFY,
        page: () => ModifyInfoPage(),
        binding: ModifyInfoBinding()),
  ];
}

//命名路由的名称
abstract class Routes {
  static const INITIAL = "/";

  //闪屏页
  static const SPLASH = "/splash";

  //登录页
  static const LOGIN = "/login";

  //Root页
  static const ROOT = "/root";

  //主页
  static const HOME = "/home";

  //发布页
  static const PUBLISH = "/publish";

  //评论弹窗
  static const COMMENT = "/comment";

  //个人主页
  static const MINE = "/mine";

  //主页详情页
  static const DETAIL = "/detail";

  //注册页
  static const REGISTER = "/register";

  //搜索页
  static const SEARCH = "/search";

  static const CLASSIFY = "/classify";
  static const HEAD = "/rootpagehead";
  //测试页
  static const TEST = "/test";
  static const LOCATE = "/locate";
  //个人信息修改页
  static const MODIFY = "/modify";
}
