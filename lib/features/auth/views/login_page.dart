import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validator_util.dart';
import '../../../core/widgets/app_button.dart';
import '../controllers/auth_controller.dart';

/// 登录页面
class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60.h),
                
                // Logo 区域
                _buildLogo(),
                
                SizedBox(height: 48.h),
                
                // 欢迎文字
                _buildWelcomeText(),
                
                SizedBox(height: 32.h),
                
                // 用户名输入框
                _buildUsernameField(),
                
                SizedBox(height: 16.h),
                
                // 密码输入框
                _buildPasswordField(),
                
                SizedBox(height: 8.h),
                
                // 错误信息
                _buildErrorMessage(),
                
                SizedBox(height: 24.h),
                
                // 登录按钮
                _buildLoginButton(),
                
                SizedBox(height: 16.h),
                
                // 注册入口
                _buildRegisterEntry(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Icon(
      Icons.rocket_launch_rounded,
      size: 80.w,
      color: AppColors.primary,
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'pages.login.welcome'.tr,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'pages.login.subtitle'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: controller.usernameController,
      decoration: InputDecoration(
        labelText: 'pages.login.username'.tr,
        hintText: 'pages.login.username_hint'.tr,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      validator: ValidatorUtil.validateUsername,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextFormField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible.value,
      decoration: InputDecoration(
        labelText: 'pages.login.password'.tr,
        hintText: 'pages.login.password_hint'.tr,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isPasswordVisible.value
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      validator: ValidatorUtil.validatePassword,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => controller.login(),
    ));
  }

  Widget _buildErrorMessage() {
    return Obx(() {
      if (controller.errorMessage.value.isEmpty) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Text(
          controller.errorMessage.value,
          style: TextStyle(
            color: AppColors.error,
            fontSize: 12.sp,
          ),
        ),
      );
    });
  }

  Widget _buildLoginButton() {
    return Obx(() => AppButton(
      text: 'pages.login.submit'.tr,
      onPressed: controller.login,
      isLoading: controller.isLoading.value,
    ));
  }

  Widget _buildRegisterEntry() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'pages.login.no_account'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        TextButton(
          onPressed: controller.goToRegister,
          child: Text(
            'pages.login.go_register'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
