import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validator_util.dart';
import '../../../core/widgets/app_button.dart';
import '../controllers/auth_controller.dart';

/// 注册页面
class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 标题
                _buildTitle(),
                
                SizedBox(height: 32.h),
                
                // 用户名输入框
                _buildUsernameField(),
                
                SizedBox(height: 16.h),
                
                // 邮箱输入框
                _buildEmailField(),
                
                SizedBox(height: 16.h),
                
                // 密码输入框
                _buildPasswordField(),
                
                SizedBox(height: 16.h),
                
                // 确认密码输入框
                _buildConfirmPasswordField(),
                
                SizedBox(height: 8.h),
                
                // 错误信息
                _buildErrorMessage(),
                
                SizedBox(height: 24.h),
                
                // 注册按钮
                _buildRegisterButton(),
                
                SizedBox(height: 16.h),
                
                // 登录入口
                _buildLoginEntry(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'pages.register.welcome'.tr,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'pages.register.subtitle'.tr,
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
        labelText: 'pages.register.username'.tr,
        hintText: 'pages.register.username_hint'.tr,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      validator: ValidatorUtil.validateUsername,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'pages.register.email'.tr,
        hintText: 'pages.register.email_hint'.tr,
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      validator: ValidatorUtil.validateEmail,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextFormField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible.value,
      decoration: InputDecoration(
        labelText: 'pages.register.password'.tr,
        hintText: 'pages.register.password_hint'.tr,
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
      textInputAction: TextInputAction.next,
    ));
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() => TextFormField(
      controller: controller.confirmPasswordController,
      obscureText: !controller.isConfirmPasswordVisible.value,
      decoration: InputDecoration(
        labelText: 'pages.register.confirm_password'.tr,
        hintText: 'pages.register.confirm_password_hint'.tr,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isConfirmPasswordVisible.value
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: controller.toggleConfirmPasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      validator: (value) {
        final passwordError = ValidatorUtil.validatePassword(value);
        if (passwordError != null) return passwordError;
        if (value != controller.passwordController.text) {
          return 'validation.password.mismatch'.tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => controller.register(),
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

  Widget _buildRegisterButton() {
    return Obx(() => AppButton(
      text: 'pages.register.submit'.tr,
      onPressed: controller.register,
      isLoading: controller.isLoading.value,
    ));
  }

  Widget _buildLoginEntry() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'pages.register.have_account'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        TextButton(
          onPressed: controller.goToLogin,
          child: Text(
            'pages.register.go_login'.tr,
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
