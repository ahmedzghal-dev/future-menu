import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/order_controller.dart';

class OrderStatusView extends GetView<OrderController> {
  const OrderStatusView({Key? key}) : super(key: key);
  
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
              'Your order status',
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
            icon: Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        return _buildOrderStatusContent();
      }),
      bottomNavigationBar: Obx(() {
        if (controller.orderStatus.value == 3) {
          return _buildPayButton();
        }
        return SizedBox.shrink();
      }),
    );
  }
  
  Widget _buildOrderStatusContent() {
    switch (controller.orderStatus.value) {
      case 1:
        return _buildPreparingStatus();
      case 2:
        return _buildAlmostReadyStatus();
      case 3:
        return _buildDoneStatus();
      default:
        return _buildPreparingStatus();
    }
  }
  
  Widget _buildPreparingStatus() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your order will be ready in',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${controller.readyInMinutes.value} minutes',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: Image.asset(
                  'assets/images/order_preparing.png',
                  height: 200.h,
                  width: 200.h,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        _buildOrderList(),
      ],
    );
  }
  
  Widget _buildAlmostReadyStatus() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your order is',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'almost ready',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: Image.asset(
                  'assets/images/order_almost_ready.png',
                  height: 200.h,
                  width: 200.h,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        _buildOrderList(),
      ],
    );
  }
  
  Widget _buildDoneStatus() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your dishes are ready.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Enjoy!',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: Image.asset(
                  'assets/images/order_done.png',
                  height: 200.h,
                  width: 200.h,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        _buildOrderList(),
      ],
    );
  }
  
  Widget _buildOrderList() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // Toggle order list expansion
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order list and prices',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Icon(
                  Icons.expand_less,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          ..._buildOrderItems(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items Total',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '\$${controller.itemsTotal.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '\$${controller.tax.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.divider),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total price',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '\$${controller.totalPrice.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildOrderItems() {
    return controller.orderItems.map((item) {
      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                item['image'] ?? 'assets/images/food_placeholder.jpg',
                width: 50.w,
                height: 50.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                item['name'] ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '${item['quantity']} ×',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '\$${item['price']?.toStringAsFixed(2) ?? '0.00'}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
  
  Widget _buildPayButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => controller.proceedToPayment(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          'Pay \$${controller.totalPrice.value.toStringAsFixed(2)}',
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