import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/location_controller.dart';
import '../../../core/theme/app_theme.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    'Set your locations',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    'assets/icons/location_pin.svg',
                    height: 24.h,
                    width: 24.h,
                    color: AppColors.secondary,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              _buildOptionCard(
                title: 'Scan QR Code',
                description: 'Choose the simply way, scan your QR Code from our table',
                icon: 'assets/icons/qr_code.svg',
                onTap: controller.scanQrCode,
              ),
              SizedBox(height: 20.h),
              _buildOptionCard(
                title: 'Select location manually',
                description: 'If you prefer to add your location manually, here is your option',
                icon: 'assets/icons/location_pin.svg',
                onTap: controller.selectLocationManually,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildOptionCard({
    required String title,
    required String description,
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 80.h,
              width: 80.h,
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 