import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/onboarding_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_pages.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("OnboardingView build called at ${DateTime.now()}");
    
    // Create a local method for navigation that doesn't depend on controller
    void handleNavigationWithFallback(Function()? controllerMethod) {
      try {
        // First attempt - use controller if available 
        if (Get.isRegistered<OnboardingController>()) {
          final ctrl = Get.find<OnboardingController>();
          if (controllerMethod != null) {
            controllerMethod();
          } else {
            // Default navigation if method is null
            Get.offNamed(Routes.AUTHENTICATION);
          }
        } else {
          // Second attempt - direct navigation
          Get.offNamed(Routes.AUTHENTICATION);
        }
      } catch (e) {
        debugPrint("Navigation error: $e");
        // Fallback to showing dialog
        _showErrorDialog(context);
      }
    }
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => handleNavigationWithFallback(
                          () => controller.skipOnboarding()),
                      child: Text(
                        'Sign up later',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Container(
                        width: 220.w,
                        height: 220.w,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/phone_image.svg',
                            height: 150.w,
                            width: 150.w,
                            placeholderBuilder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        'Full contactless experience',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'From ordering to paying, that\'s all contactless',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            width: 10.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppColors.divider,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            width: 10.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppColors.divider,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: ElevatedButton(
                  onPressed: () => handleNavigationWithFallback(
                      () => controller.goToAuthentication()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showErrorDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Navigation Note'),
          content: Text('This is a UI demo only. Full navigation is not implemented.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
} 