import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/splash_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_pages.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("SplashView build called at ${DateTime.now()}");
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Use FutureBuilder to load SVG more efficiently
                        FutureBuilder(
                          future: Future.delayed(Duration(milliseconds: 100)),
                          builder: (context, snapshot) {
                            return SvgPicture.asset(
                              'assets/images/food_plate.svg',
                              height: 160.w,
                              width: 160.w,
                              placeholderBuilder: (context) => SizedBox(
                                height: 160.w,
                                width: 160.w,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                        SizedBox(height: 30.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Eat\n',
                                style: TextStyle(
                                  fontSize: 38.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              TextSpan(
                                text: 'Easy',
                                style: TextStyle(
                                  fontSize: 38.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h),
                        CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 3,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
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
} 