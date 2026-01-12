import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/translations/app_translations.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

/// 首页
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('common.app_name'.tr),
      centerTitle: true,
      elevation: 0,
      actions: [
        // 语言切换
        PopupMenuButton<String>(
          icon: const Icon(Icons.language),
          onSelected: (value) {
            if (value == 'zh') {
              SettingsHelper.toZhCN();
            } else {
              SettingsHelper.toEnUS();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'zh',
              child: Row(
                children: [
                  const Text('🇨🇳'),
                  const SizedBox(width: 8),
                  Text('pages.settings.chinese'.tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'en',
              child: Row(
                children: [
                  const Text('🇺🇸'),
                  const SizedBox(width: 8),
                  Text('pages.settings.english'.tr),
                ],
              ),
            ),
          ],
        ),
        // 退出登录
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Get.find<AuthController>().logout();
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      switch (controller.currentIndex.value) {
        case 0:
          return _buildHomeContent(context);
        case 1:
          return _buildProfileContent(context);
        case 2:
          return _buildSettingsContent(context);
        default:
          return _buildHomeContent(context);
      }
    });
  }

  Widget _buildHomeContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return SingleChildScrollView(
          padding: EdgeInsets.all(isWide ? 32 : 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Hero 区域
                  _buildHeroSection(isWide),
                  const SizedBox(height: 40),
                  // 功能卡片
                  _buildFeatureCards(context, isWide, isDark),
                  const SizedBox(height: 40),
                  // 快速操作
                  _buildQuickActions(context, isDark),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(bool isWide) {
    return Container(
      padding: EdgeInsets.all(isWide ? 40 : 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: isWide ? 100 : 80,
            height: isWide ? 100 : 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.rocket_launch_rounded,
              size: isWide ? 50 : 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'pages.home.welcome'.tr,
            style: TextStyle(
              fontSize: isWide ? 28 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'pages.home.intro'.tr,
            style: TextStyle(
              fontSize: isWide ? 16 : 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCards(BuildContext context, bool isWide, bool isDark) {
    final theme = Theme.of(context);
    final features = [
      {
        'icon': Icons.flash_on_rounded,
        'title': 'GetX',
        'desc': '状态管理',
        'color': const Color(0xFFFF9800),
      },
      {
        'icon': Icons.route_rounded,
        'title': 'Router',
        'desc': '路由管理',
        'color': const Color(0xFF2196F3),
      },
      {
        'icon': Icons.storage_rounded,
        'title': 'Hive',
        'desc': '本地存储',
        'color': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.translate_rounded,
        'title': 'i18n',
        'desc': '国际化',
        'color': const Color(0xFF9C27B0),
      },
      {
        'icon': Icons.palette_rounded,
        'title': 'Theme',
        'desc': '主题系统',
        'color': const Color(0xFFE91E63),
      },
      {
        'icon': Icons.widgets_rounded,
        'title': 'Widgets',
        'desc': '通用组件',
        'color': const Color(0xFF00BCD4),
      },
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: features.map((feature) {
        final color = feature['color'] as Color;
        return Container(
          width: isWide ? 180 : 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  size: 26,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                feature['title'] as String,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                feature['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            '快速开始',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActionTile(
                context: context,
                icon: Icons.menu_book_rounded,
                iconColor: const Color(0xFF2196F3),
                title: '查看文档',
                subtitle: '了解项目架构设计',
                isDark: isDark,
                onTap: () {},
              ),
              const Divider(height: 1, indent: 72),
              _buildActionTile(
                context: context,
                icon: Icons.bug_report_rounded,
                iconColor: const Color(0xFFFF5722),
                title: '提交反馈',
                subtitle: '报告问题或建议',
                isDark: isDark,
                onTap: () {},
              ),
              const Divider(height: 1, indent: 72),
              _buildActionTile(
                context: context,
                icon: Icons.star_rounded,
                iconColor: const Color(0xFFFFC107),
                title: '给个 Star',
                subtitle: '支持开源项目',
                isDark: isDark,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title, 
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(
        subtitle, 
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right, 
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return SingleChildScrollView(
          padding: EdgeInsets.all(isWide ? 32 : 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // 头像
                  _buildAvatar(),
                  const SizedBox(height: 20),
                  // 用户名
                  Text(
                    controller.displayName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'pages.profile.title'.tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 信息卡片
                  _buildProfileCard(context, isDark),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.3),
                AppColors.secondary.withValues(alpha: 0.3),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 50,
              color: AppColors.primary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Icon(
            Icons.check,
            size: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context: context,
            icon: Icons.email_outlined,
            label: '邮箱',
            value: 'admin@example.com',
            isDark: isDark,
          ),
          const Divider(height: 32),
          _buildInfoRow(
            context: context,
            icon: Icons.calendar_today_outlined,
            label: '注册时间',
            value: '2026-01-01',
            isDark: isDark,
          ),
          const Divider(height: 32),
          _buildInfoRow(
            context: context,
            icon: Icons.verified_outlined,
            label: '账号状态',
            value: '已认证',
            valueColor: AppColors.success,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return ListView(
          padding: EdgeInsets.all(isWide ? 32 : 16),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    // 设置分组
                    _buildSettingsGroup(
                      context: context,
                      children: [
                        _buildSettingsTile(
                          context: context,
                          icon: Icons.palette_outlined,
                          iconColor: Colors.purple,
                          title: 'pages.settings.theme'.tr,
                          isDark: isDark,
                          onTap: _showThemeDialog,
                        ),
                        _buildSettingsTile(
                          context: context,
                          icon: Icons.language,
                          iconColor: Colors.blue,
                          title: 'pages.settings.language'.tr,
                          subtitle: LocaleHelper.currentLanguageName,
                          isDark: isDark,
                          onTap: () {
                            if (LocaleHelper.isChinese) {
                              SettingsHelper.toEnUS();
                            } else {
                              SettingsHelper.toZhCN();
                            }
                          },
                        ),
                        _buildSettingsTile(
                          context: context,
                          icon: Icons.info_outline,
                          iconColor: Colors.teal,
                          title: 'pages.settings.about'.tr,
                          isDark: isDark,
                          onTap: _showAboutDialog,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // 退出登录
                    _buildSettingsGroup(
                      context: context,
                      children: [
                        _buildSettingsTile(
                          context: context,
                          icon: Icons.logout,
                          iconColor: AppColors.error,
                          title: 'pages.settings.logout'.tr,
                          titleColor: AppColors.error,
                          showArrow: false,
                          isDark: isDark,
                          onTap: _showLogoutConfirm,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // 版本信息
                    Center(
                      child: Text(
                        'v1.0.0',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsGroup({
    required BuildContext context,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final isLast = entry.key == children.length - 1;
          return Column(
            children: [
              entry.value,
              if (!isLast) const Divider(height: 1, indent: 72),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isDark,
    String? subtitle,
    Color? titleColor,
    bool showArrow = true,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? theme.textTheme.bodyLarge?.color, 
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            )
          : null,
      trailing: showArrow
          ? Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            )
          : null,
      onTap: onTap,
    );
  }

  void _showThemeDialog() {
    Get.dialog<void>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('pages.settings.theme'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode_rounded),
              title: Text('pages.settings.light_mode'.tr),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                SettingsHelper.changeTheme(ThemeMode.light);
                Get.back<void>();
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode_rounded),
              title: Text('pages.settings.dark_mode'.tr),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                SettingsHelper.changeTheme(ThemeMode.dark);
                Get.back<void>();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_brightness_rounded),
              title: Text('pages.settings.system_mode'.tr),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                SettingsHelper.changeTheme(ThemeMode.system);
                Get.back<void>();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    Get.dialog<void>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Flutter Boost'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'pages.settings.version'.tr}: 1.0.0'),
            const SizedBox(height: 8),
            const Text('一个强大的 Flutter 企业级脚手架'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back<void>(),
            child: Text('common.close'.tr),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirm() {
    Get.dialog<void>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('pages.settings.logout'.tr),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back<void>(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back<void>();
              Get.find<AuthController>().logout();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: Text('common.confirm'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Obx(() => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: 'pages.home.title'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: 'pages.profile.title'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: 'pages.settings.title'.tr,
            ),
          ],
        ));
  }
}
