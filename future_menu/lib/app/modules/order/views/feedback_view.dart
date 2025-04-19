import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/order_controller.dart';

class FeedbackView extends GetView<OrderController> {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            Text(
              'Gram Bistro',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Checkout',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => controller.skipFeedback(),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),
                      Image.asset(
                        'assets/images/star.png', // Star image from Figma
                        width: 80.w,
                        height: 80.h,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Tell us about your experience',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'We love to hear from you how was the whole experience in our restaurant.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      _buildStarRating(),
                      SizedBox(height: 24.h),
                      _buildFeedbackField(),
                    ],
                  ),
                ),
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => IconButton(
              icon: Icon(
                controller.rating.value > index ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 36.sp,
              ),
              onPressed: () => controller.setRating(index + 1),
            ),
          ),
        ));
  }

  Widget _buildFeedbackField() {
    return TextField(
      onChanged: controller.setFeedback,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Share your experience with us...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () => controller.submitFeedback(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          'Add feedback',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
} 