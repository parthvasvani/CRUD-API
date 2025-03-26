import 'package:get/get.dart';
import 'package:login_api/routes/app_routes.dart';

import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginPage(),),
    GetPage(name: AppRoutes.register, page: () => RegisterPage(),),
    GetPage(name: AppRoutes.home, page: () => HomePage(),),
  ];
}