import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/location_controller.dart';
import '../../../core/theme/app_theme.dart';

class LocationQrView extends GetView<LocationController> {
  const LocationQrView({Key? key}) : super(key: key);

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
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Scan QR Code',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              Container(
                width: 250.w,
                height: 250.w,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  // In a real app, this would be a camera feed
                  child: SvgPicture.asset(
                    'assets/icons/qr_code.svg',
                    height: 120.h,
                    width: 120.h,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Choose the simply way, scan your QR Code from our table',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: ElevatedButton(
                  onPressed: () {
                    // In a real app, this would handle the scanned code
                    controller.continueToRestaurants();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Continue',
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
} 