import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
              LocaleHelper.toZhCN();
            } else {
              LocaleHelper.toEnUS();
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

  Widget _buildBody() {
    return Obx(() {
      switch (controller.currentIndex.value) {
        case 0:
          return _buildHomeContent();
        case 1:
          return _buildProfileContent();
        case 2:
          return _buildSettingsContent();
        default:
          return _buildHomeContent();
      }
    });
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Logo 区域
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.secondary.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.rocket_launch_rounded,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          // 欢迎文字
          Text(
            'pages.home.welcome'.tr,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'pages.home.intro'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // 功能卡片
          _buildFeatureCards(),
          const SizedBox(height: 24),
          // 快速操作
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    final features = [
      {
        'icon': Icons.flash_on_rounded,
        'title': 'GetX',
        'desc': '状态管理',
        'color': Colors.orange,
      },
      {
        'icon': Icons.route_rounded,
        'title': 'Router',
        'desc': '路由管理',
        'color': Colors.blue,
      },
      {
        'icon': Icons.storage_rounded,
        'title': 'Hive',
        'desc': '本地存储',
        'color': Colors.green,
      },
      {
        'icon': Icons.translate_rounded,
        'title': 'i18n',
        'desc': '国际化',
        'color': Colors.purple,
      },
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: features.map((feature) {
        return Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: (feature['color'] as Color).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (feature['color'] as Color).withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                feature['icon'] as IconData,
                size: 28,
                color: feature['color'] as Color,
              ),
              const SizedBox(height: 8),
              Text(
                feature['title'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                feature['desc'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            '快速开始',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActionTile(
                icon: Icons.code_rounded,
                title: '查看文档',
                subtitle: '了解项目架构设计',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
              _buildActionTile(
                icon: Icons.bug_report_rounded,
                title: '提交反馈',
                subtitle: '报告问题或建议',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 56),
              _buildActionTile(
                icon: Icons.star_rounded,
                title: '给个 Star',
                subtitle: '支持开源项目',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // 头像
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.secondary.withValues(alpha: 0.2),
                    ],
                  ),
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
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 用户名
          Text(
            controller.displayName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'pages.profile.title'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          // 信息卡片
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.email_outlined,
                  label: '邮箱',
                  value: 'admin@example.com',
                ),
                const Divider(height: 24),
                _buildInfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: '注册时间',
                  value: '2026-01-01',
                ),
                const Divider(height: 24),
                _buildInfoRow(
                  icon: Icons.verified_outlined,
                  label: '账号状态',
                  value: '已认证',
                  valueColor: AppColors.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 设置分组
        _buildSettingsGroup([
          _buildSettingsTile(
            icon: Icons.palette_outlined,
            iconColor: Colors.purple,
            title: 'pages.settings.theme'.tr,
            onTap: () {
              _showThemeDialog();
            },
          ),
          _buildSettingsTile(
            icon: Icons.language,
            iconColor: Colors.blue,
            title: 'pages.settings.language'.tr,
            subtitle: LocaleHelper.currentLanguageName,
            onTap: () {
              if (LocaleHelper.isChinese) {
                LocaleHelper.toEnUS();
              } else {
                LocaleHelper.toZhCN();
              }
            },
          ),
          _buildSettingsTile(
            icon: Icons.info_outline,
            iconColor: Colors.teal,
            title: 'pages.settings.about'.tr,
            onTap: () {
              _showAboutDialog();
            },
          ),
        ]),
        const SizedBox(height: 16),
        // 退出登录
        _buildSettingsGroup([
          _buildSettingsTile(
            icon: Icons.logout,
            iconColor: AppColors.error,
            title: 'pages.settings.logout'.tr,
            titleColor: AppColors.error,
            showArrow: false,
            onTap: () {
              _showLogoutConfirm();
            },
          ),
        ]),
        const SizedBox(height: 24),
        // 版本信息
        const Center(
          child: Text(
            'v1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final isLast = entry.key == children.length - 1;
          return Column(
            children: [
              entry.value,
              if (!isLast) const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Color? titleColor,
    bool showArrow = true,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontSize: 15),
      ),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 13)) : null,
      trailing: showArrow
          ? const Icon(Icons.chevron_right, color: AppColors.textSecondary)
          : null,
      onTap: onTap,
    );
  }

  void _showThemeDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('pages.settings.theme'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text('pages.settings.light_mode'.tr),
              onTap: () {
                Get.changeThemeMode(ThemeMode.light);
                Get.back<void>();
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text('pages.settings.dark_mode'.tr),
              onTap: () {
                Get.changeThemeMode(ThemeMode.dark);
                Get.back<void>();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_brightness),
              title: Text('pages.settings.system_mode'.tr),
              onTap: () {
                Get.changeThemeMode(ThemeMode.system);
                Get.back<void>();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    Get.dialog(
      AlertDialog(
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
    Get.dialog(
      AlertDialog(
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

  Widget _buildBottomNav() {
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
