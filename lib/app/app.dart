import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/app_routes.dart';
import 'routes/app_pages.dart';
import 'bindings/app_binding.dart';
import '../core/theme/app_theme.dart';
import '../shared/constants/app_constants.dart';
import '../shared/translations/app_translations.dart';

/// 应用根组件
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // 设计稿尺寸（以 iPhone 14 Pro 为基准）
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          // 应用标题
          title: AppConstants.appName,

          // 调试模式标识
          debugShowCheckedModeBanner: false,

          // 国际化配置
          translations: AppTranslations(),
          locale: AppTranslations.systemLocale,
          fallbackLocale: AppTranslations.fallbackLocale,

          // 主题配置
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,

          // 路由配置
          initialRoute: AppPages.initial,
          getPages: AppPages.pages,
          unknownRoute: GetPage(
            name: '/not-found',
            page: () => const _NotFoundPage(),
          ),

          // 全局依赖注入
          initialBinding: AppBinding(),

          // 默认过渡动画
          defaultTransition: Transition.cupertino,
          transitionDuration: AppConstants.defaultAnimationDuration,

          // 滚动行为（支持鼠标滚轮）
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: true,
          ),
        );
      },
    );
  }
}

/// 404 页面
class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pages.not_found.title'.tr)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'pages.not_found.code'.tr,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'pages.not_found.message'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Get.offAllNamed(AppRoutes.home),
              icon: const Icon(Icons.home),
              label: Text('pages.not_found.back_home'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

