import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/app_routes.dart';
import 'routes/app_pages.dart';
import 'bindings/app_binding.dart';
import '../core/theme/app_theme.dart';
import '../core/storage/storage_service.dart';
import '../shared/constants/app_constants.dart';
import '../shared/constants/storage_keys.dart';
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
          locale: _getSavedLocale(),
          fallbackLocale: AppTranslations.fallbackLocale,

          // 主题配置
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _getSavedThemeMode(),

          // 路由配置
          initialRoute: AppPages.initial,
          getPages: AppPages.pages,
          unknownRoute: GetPage<dynamic>(
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

  /// 获取保存的主题模式
  ThemeMode _getSavedThemeMode() {
    try {
      final storage = Get.find<StorageService>();
      final themeValue = storage.getString(StorageKeys.themeMode);
      switch (themeValue) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    } catch (e) {
      return ThemeMode.system;
    }
  }

  /// 获取保存的语言
  Locale _getSavedLocale() {
    try {
      final storage = Get.find<StorageService>();
      final langValue = storage.getString(StorageKeys.language);
      switch (langValue) {
        case 'zh_CN':
          return const Locale('zh', 'CN');
        case 'en_US':
          return const Locale('en', 'US');
        default:
          return AppTranslations.systemLocale;
      }
    } catch (e) {
      return AppTranslations.systemLocale;
    }
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
              onPressed: () => Get.offAllNamed<void>(AppRoutes.home),
              icon: const Icon(Icons.home),
              label: Text('pages.not_found.back_home'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

/// 主题和语言持久化辅助类
class SettingsHelper {
  SettingsHelper._();

  /// 保存主题模式
  static Future<void> saveThemeMode(ThemeMode mode) async {
    final storage = Get.find<StorageService>();
    String value;
    switch (mode) {
      case ThemeMode.light:
        value = 'light';
      case ThemeMode.dark:
        value = 'dark';
      case ThemeMode.system:
        value = 'system';
    }
    await storage.setString(StorageKeys.themeMode, value);
  }

  /// 保存语言
  static Future<void> saveLocale(Locale locale) async {
    final storage = Get.find<StorageService>();
    final value = '${locale.languageCode}_${locale.countryCode}';
    await storage.setString(StorageKeys.language, value);
  }

  /// 切换到中文
  static Future<void> toZhCN() async {
    const locale = Locale('zh', 'CN');
    Get.updateLocale(locale);
    await saveLocale(locale);
  }

  /// 切换到英文
  static Future<void> toEnUS() async {
    const locale = Locale('en', 'US');
    Get.updateLocale(locale);
    await saveLocale(locale);
  }

  /// 切换主题
  static Future<void> changeTheme(ThemeMode mode) async {
    Get.changeThemeMode(mode);
    await saveThemeMode(mode);
  }
}
