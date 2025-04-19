import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/verify_code_controller.dart';
import '../../../core/theme/app_theme.dart';

class VerifyCodeView extends GetView<VerifyCodeController> {
  const VerifyCodeView({Key? key}) : super(key: key);

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
          'Verify Code',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
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
                    'Verify Code',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.bolt,
                    color: AppColors.secondary,
                    size: 24.sp,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Obx(() => RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: 'We just sent a 4-digit verification code to ',
                    ),
                    TextSpan(
                      text: controller.email.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: '. Enter the code in the box below to continue.',
                    ),
                  ],
                ),
              )),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDigitField(
                    controller: controller.digit1Controller,
                    focusNode: controller.digit1FocusNode,
                    nextFocusNode: controller.digit2FocusNode,
                  ),
                  SizedBox(width: 10.w),
                  _buildDigitField(
                    controller: controller.digit2Controller,
                    focusNode: controller.digit2FocusNode,
                    nextFocusNode: controller.digit3FocusNode,
                  ),
                  SizedBox(width: 10.w),
                  _buildDigitField(
                    controller: controller.digit3Controller,
                    focusNode: controller.digit3FocusNode,
                    nextFocusNode: controller.digit4FocusNode,
                  ),
                  SizedBox(width: 10.w),
                  _buildDigitField(
                    controller: controller.digit4Controller,
                    focusNode: controller.digit4FocusNode,
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive a code?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.resendCode,
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isCodeValid.value 
                      ? controller.verifyCode
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
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDigitField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    bool isLast = false,
  }) {
    return SizedBox(
      width: 65.w,
      height: 65.w,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
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
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1 && !isLast && nextFocusNode != null) {
            nextFocusNode.requestFocus();
          }
        },
      ),
    );
  }
} 