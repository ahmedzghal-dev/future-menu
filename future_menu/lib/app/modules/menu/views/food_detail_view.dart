import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/menu_controller.dart' as app_menu;
import '../../../core/theme/app_theme.dart';

class FoodDetailView extends GetView<app_menu.MenuController> {
  const FoodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.restaurantName.value,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
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
        final food = controller.selectedFoodItem.value;
        if (food.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food image at the top
              Container(
                height: 240.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          food['image'] ?? 'assets/images/food_placeholder.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        right: 16.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text(
                                '${food['rating']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    
                    // Food name and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food['name'] ?? '',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '\$${food['price']?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Food description
                    Text(
                      food['description'] ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Nutrition information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutritionItem(
                          '${food['nutrition']?['calories'] ?? 0}',
                          'kcal',
                        ),
                        _buildNutritionItem(
                          '${food['nutrition']?['grams'] ?? 0}',
                          'grams',
                        ),
                        _buildNutritionItem(
                          '${food['nutrition']?['proteins'] ?? 0}',
                          'proteins',
                        ),
                        _buildNutritionItem(
                          '${food['nutrition']?['carbs'] ?? 0}',
                          'carbs',
                        ),
                        _buildNutritionItem(
                          '${food['nutrition']?['fats'] ?? 0}',
                          'fats',
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Ingredients
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Ingredients row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var ingredient in food['ingredients'] ?? [])
                            _buildIngredientItem(ingredient),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Toppings
                    Text(
                      'Add toppings',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Toppings list
                    Column(
                      children: [
                        for (var topping in food['toppings'] ?? [])
                          _buildToppingItem(
                            topping['name'],
                            topping['price'],
                          ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Recommended sides
                    Text(
                      'Recommended sides',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Sides list
                    Column(
                      children: [
                        for (var side in food['recommended_sides'] ?? [])
                          _buildSideItem(side),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Add a request
                    Text(
                      'Add a request',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Request text field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        onChanged: controller.setRequestText,
                        maxLength: controller.requestCharLimit,
                        decoration: InputDecoration(
                          hintText: 'Ex: Don\'t add onion',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.w),
                          counterText: '',
                        ),
                      ),
                    ),
                    
                    // Character counter
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h, right: 8.w),
                        child: Text(
                          '${controller.requestText.value.length}/${controller.requestCharLimit}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
        child: Row(
          children: [
            // Quantity selector
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: AppColors.textPrimary),
                    onPressed: controller.decreaseQuantity,
                  ),
                  Obx(() => Text(
                    '${controller.quantity.value}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  )),
                  IconButton(
                    icon: Icon(Icons.add, color: AppColors.textPrimary),
                    onPressed: controller.increaseQuantity,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Add to order button
            Expanded(
              child: ElevatedButton(
                onPressed: controller.addToCartWithOptions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add to order',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Obx(() => Text(
                      '\$${controller.totalPrice.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String value, String label) {
    return Container(
      width: 60.w,
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(String ingredient) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Icon(
                Icons.egg_outlined,
                size: 40.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            ingredient,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToppingItem(String name, double price) {
    return Obx(() {
      final isSelected = controller.selectedToppings.contains(name);
      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => controller.toggleTopping(name),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Text(
              '+\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSideItem(Map<String, dynamic> side) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              side['image'] ?? 'assets/images/food_placeholder.jpg',
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
                  side['name'] ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${side['rating'] ?? 0}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '(${side['reviews'] ?? 0} reviews)',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${side['price']?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            final quantity = controller.selectedSides[side['name']] ?? 0;
            return Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: AppColors.primary),
                  onPressed: () => controller.updateSideQuantity(side['name'], -1),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                SizedBox(width: 8.w),
                Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  icon: Icon(Icons.add, color: AppColors.primary),
                  onPressed: () => controller.updateSideQuantity(side['name'], 1),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
} 