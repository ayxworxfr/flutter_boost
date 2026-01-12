import 'package:get/get.dart';

import 'app_routes.dart';
import '../middlewares/auth_middleware.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/views/login_page.dart';
import '../../features/auth/views/register_page.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_page.dart';
import '../../features/splash/views/splash_page.dart';
import '../../features/splash/bindings/splash_binding.dart';

/// 路由页面配置
class AppPages {
  /// 初始路由
  static const initial = AppRoutes.splash;

  /// 路由页面列表
  static final pages = <GetPage<dynamic>>[
    // 启动页
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),

    // 登录页
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),

    // 注册页
    GetPage<dynamic>(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // 首页
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fadeIn,
    ),
  ];
}

