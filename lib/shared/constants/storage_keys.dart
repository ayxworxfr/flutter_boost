/// 存储 Key 常量定义
class StorageKeys {
  StorageKeys._();

  // ==================== SharedPreferences Keys ====================
  /// 主题模式
  static const String themeMode = 'theme_mode';

  /// 语言设置
  static const String language = 'language';

  /// 是否首次启动
  static const String isFirstLaunch = 'is_first_launch';

  /// 是否同意隐私政策
  static const String privacyAgreed = 'privacy_agreed';

  // ==================== Hive Box Names ====================
  /// 用户信息 Box
  static const String userBox = 'user_box';

  /// 缓存数据 Box
  static const String cacheBox = 'cache_box';

  /// 设置 Box
  static const String settingsBox = 'settings_box';

  // ==================== Hive Keys ====================
  /// 当前用户
  static const String currentUser = 'current_user';

  /// Access Token
  static const String accessToken = 'access_token';

  /// Refresh Token
  static const String refreshToken = 'refresh_token';

  /// Token 过期时间
  static const String tokenExpiry = 'token_expiry';
}
