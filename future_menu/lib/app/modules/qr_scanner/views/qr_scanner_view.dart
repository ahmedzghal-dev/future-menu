import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/qr_scanner_controller.dart';

class QrScannerView extends GetView<QrScannerController> {
  const QrScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                'The last step before you go',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              _buildQrScannerArea(),
              SizedBox(height: 24.h),
              Text(
                'Please scan the QR Code at the\nexit of restaurant.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              _buildButtons(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrScannerArea() {
    return Container(
      width: 280.w,
      height: 280.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          // QR code placeholder
          Center(
            child: Image.asset(
              'assets/images/qr_code_placeholder.png',
              width: 200.w,
              height: 200.w,
              fit: BoxFit.contain,
            ),
          ),
          // Corner decorations
          Positioned(
            top: 0,
            left: 0,
            child: _buildCorner(CornerPosition.topLeft),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _buildCorner(CornerPosition.topRight),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: _buildCorner(CornerPosition.bottomLeft),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildCorner(CornerPosition.bottomRight),
          ),
          // Scanning effect
          Obx(() {
            if (controller.isScanning.value) {
              return Container(
                width: double.infinity,
                height: 2.h,
                color: AppColors.primary.withOpacity(0.5),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildCorner(CornerPosition position) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: position == CornerPosition.topLeft || position == CornerPosition.bottomLeft
                ? Colors.orange
                : Colors.transparent,
            width: 3.w,
          ),
          top: BorderSide(
            color: position == CornerPosition.topLeft || position == CornerPosition.topRight
                ? Colors.orange
                : Colors.transparent,
            width: 3.w,
          ),
          right: BorderSide(
            color: position == CornerPosition.topRight || position == CornerPosition.bottomRight
                ? Colors.orange
                : Colors.transparent,
            width: 3.w,
          ),
          bottom: BorderSide(
            color: position == CornerPosition.bottomLeft || position == CornerPosition.bottomRight
                ? Colors.orange
                : Colors.transparent,
            width: 3.w,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        TextButton(
          onPressed: () => controller.scanLater(),
          child: Text(
            'Scan later',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => controller.startScanning(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Scan now',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum CornerPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
} 