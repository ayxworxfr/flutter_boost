import 'package:get/get.dart';

import 'app_routes.dart';
import '../middlewares/auth_middleware.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/views/login_page.dart';
import '../../features/auth/views/register_page.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_page.dart';

/// 路由页面配置
class AppPages {
  /// 初始路由
  static const initial = AppRoutes.home;

  /// 路由页面列表
  static final pages = [
    // 登录页
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),

    // 注册页
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // 首页
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fadeIn,
    ),
  ];
}

