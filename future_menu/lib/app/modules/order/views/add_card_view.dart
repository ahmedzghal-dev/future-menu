import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/order_controller.dart';

class AddCardView extends GetView<OrderController> {
  const AddCardView({Key? key}) : super(key: key);

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
            icon: Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Add a new card',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      _buildCardNumberField(),
                      SizedBox(height: 16.h),
                      _buildCardholderNameField(),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildExpiryDateField(),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _buildCVVField(),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      _buildSaveCardCheckbox(),
                    ],
                  ),
                ),
              ),
              _buildAddCardButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextField(
      onChanged: (value) => controller.cardNumber.value = value,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Card number',
        hintText: '1234 5678 9012 3456',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: Image.asset(
            'assets/images/card_logo.png',
            width: 24.w,
            height: 24.w,
          ),
        ),
      ),
    );
  }

  Widget _buildCardholderNameField() {
    return TextField(
      onChanged: (value) => controller.cardName.value = value,
      decoration: InputDecoration(
        labelText: 'Cardholder name',
        hintText: 'Robert Fox',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildExpiryDateField() {
    return TextField(
      onChanged: (value) => controller.expiryDate.value = value,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: 'Expire date',
        hintText: 'MM/YY',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildCVVField() {
    return TextField(
      onChanged: (value) => controller.cvv.value = value,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'CVV',
        hintText: '123',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildSaveCardCheckbox() {
    return Obx(() => Row(
          children: [
            Checkbox(
              value: controller.saveCard.value,
              onChanged: (value) => controller.saveCard.value = value ?? false,
              activeColor: AppColors.primary,
            ),
            Expanded(
              child: Text(
                'Save this card for future payments',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildAddCardButton() {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {
          controller.addNewCard();
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          'Add card',
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