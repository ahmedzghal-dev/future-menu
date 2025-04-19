import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/create_account_controller.dart';
import '../../../core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Create account',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Text(
                      'Getting started!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.thumb_up,
                      color: AppColors.secondary,
                      size: 24.sp,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'Look like you are new to us! Create an account for a complete experience.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 30.h),
                _buildTextField(
                  controller: controller.usernameController,
                  hintText: 'Username',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  enabled: Get.arguments == null || Get.arguments['email'] == null,
                ),
                SizedBox(height: 16.h),
                _buildPhoneField(),
                SizedBox(height: 16.h),
                _buildPasswordField(),
                SizedBox(height: 40.h),
                Obx(() => ElevatedButton(
                  onPressed: controller.isFormValid.value 
                      ? controller.createAccount
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.divider,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
      ),
    );
  }
  
  Widget _buildPhoneField() {
    return TextField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Phone number',
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16.sp,
        ),
        prefixIcon: Container(
          width: 70.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/us_flag.svg',
                width: 24.w,
                height: 16.h,
              ),
              Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
            ],
          ),
        ),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
  
  Widget _buildPasswordField() {
    return Obx(() => TextField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible.value,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16.sp,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isPasswordVisible.value 
                ? Icons.visibility_off 
                : Icons.visibility,
            color: AppColors.textSecondary,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    ));
  }
} 