import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../../../core/theme/app_theme.dart';

class CartEditView extends GetView<CartController> {
  const CartEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
              'Your order',
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
        if (controller.cartItems.isEmpty) {
          return _buildEmptyCart();
        }
        return _buildCartItems();
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) {
          return SizedBox.shrink();
        }
        return _buildBottomBar();
      }),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add some delicious items to your cart',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: controller.addMoreFood,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Browse Menu',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return _buildCartItemCard(item, index);
            },
          ),
        ),
        _buildAddMoreFood(),
      ],
    );
  }

  Widget _buildCartItemCard(Map<String, dynamic> item, int index) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    item['image'] ?? 'assets/images/food_placeholder.jpg',
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${item['rating'] ?? 0}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '(${item['reviews'] ?? 0} reviews)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '\$${item['price']?.toStringAsFixed(2) ?? '0.00'}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.grey),
                      onPressed: () => controller.decrementQuantity(index),
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.all(8.w),
                    ),
                    Text(
                      '${item['quantity'] ?? 1}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: AppColors.primary),
                      onPressed: () => controller.incrementQuantity(index),
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.all(8.w),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (index == 1) // For demo, show delete button on the second item
          Positioned(
            right: 0,
            top: 0,
            bottom: 16.h,
            child: GestureDetector(
              onTap: () => controller.removeFromCart(index),
              child: Container(
                width: 50.w,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddMoreFood() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: TextButton.icon(
        onPressed: controller.addMoreFood,
        icon: Icon(Icons.add_circle_outline, color: AppColors.primary),
        label: Text(
          'Add more food to order',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
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
        onPressed: controller.checkout,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_checkout, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              'Send order',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
} 