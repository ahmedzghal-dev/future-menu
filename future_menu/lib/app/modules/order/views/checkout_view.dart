import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/order_controller.dart';

class CheckoutView extends GetView<OrderController> {
  const CheckoutView({Key? key}) : super(key: key);
  
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
            icon: Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isCardFormOpen.value) {
          return const SizedBox.shrink(); // Card form will be shown in a separate view
        } else if (controller.savedCards.isEmpty) {
          return _buildEmptyCardState();
        } else {
          return _buildCheckoutContent();
        }
      }),
      bottomNavigationBar: Obx(() {
        if (!controller.isCardFormOpen.value && controller.savedCards.isNotEmpty) {
          return _buildPayButton();
        }
        return const SizedBox.shrink();
      }),
    );
  }
  
  Widget _buildEmptyCardState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/credit_card.png',
              height: 120.h,
              width: 120.h,
            ),
            SizedBox(height: 24.h),
            Text(
              "You don't have any card",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please add a credit card or a debit card in order to pay your order.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed('/add-card'),
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'Add a new card',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCheckoutContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPaymentMethodSection(),
          SizedBox(height: 24.h),
          _buildOrderSummarySection(),
          SizedBox(height: 24.h),
          _buildPromoCodeSection(),
          SizedBox(height: 24.h),
          _buildTipsSection(),
        ],
      ),
    );
  }
  
  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment method',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/add-card'),
              child: Text(
                'Add a new card',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildCreditCard(),
      ],
    );
  }
  
  Widget _buildCreditCard() {
    if (controller.savedCards.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final card = controller.savedCards.first;
    
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background design elements
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Card content
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/mastercard_logo.png',
                      width: 40.w,
                      height: 24.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card['number'].toString().replaceAllMapped(
                            RegExp(r'.{4}'),
                            (match) => '${match.group(0)} ',
                          ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card['name'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          card['expiry'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
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
          child: Column(
            children: [
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
              if (controller.discountAmount.value > 0) ...[
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '-\$${controller.discountAmount.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
              if (controller.tipAmount.value > 0) ...[
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '\$${controller.tipAmount.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
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
        ),
      ],
    );
  }
  
  Widget _buildPromoCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.discount_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Apply discount code',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => controller.discountCode.value = value,
                  decoration: InputDecoration(
                    hintText: 'Enter discount code',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => controller.applyDiscountCode(controller.discountCode.value),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.payments_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Add tips',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.divider),
          ),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTipButton(2.0),
                  _buildTipButton(3.0),
                  _buildTipButton(5.0),
                  _buildTipButton(10.0),
                ],
              )),
        ),
      ],
    );
  }
  
  Widget _buildTipButton(double amount) {
    final isSelected = controller.tipAmount.value == amount;
    
    return GestureDetector(
      onTap: () => controller.addTip(amount),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Text(
          '\$$amount',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
  
  Widget _buildPayButton() {
    return Container(
      padding: EdgeInsets.all(24.w),
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
      child: SizedBox(
        height: 50.h,
        child: ElevatedButton(
          onPressed: controller.completePayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
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
      ),
    );
  }
} 