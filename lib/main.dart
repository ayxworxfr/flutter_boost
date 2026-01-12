import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'core/config/env_config.dart';
import 'core/storage/storage_service.dart';
import 'core/network/http_client.dart';
import 'core/utils/logger_util.dart';
import 'features/auth/services/auth_service.dart';

/// 应用入口
void main() async {
  // 确保 Flutter 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 加载环境配置
  await EnvConfig.init();

  // 设置系统 UI 样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // 初始化服务
  await _initServices();

  // 运行应用
  runApp(const App());
}

/// 初始化服务
Future<void> _initServices() async {
  LoggerUtil.i('开始初始化服务...');
  LoggerUtil.i('当前环境: ${EnvConfig.appEnv}');

  // 初始化存储服务
  await Get.putAsync<StorageService>(() => StorageService().init());
  LoggerUtil.i('存储服务初始化完成');

  // 初始化网络客户端
  Get.put<HttpClient>(HttpClient());
  LoggerUtil.i('网络客户端初始化完成');

  // 初始化认证服务
  final authService = Get.put<AuthService>(AuthService());
  await authService.loadUserFromLocal();
  LoggerUtil.i('认证服务初始化完成');

  LoggerUtil.i('所有服务初始化完成');
}
