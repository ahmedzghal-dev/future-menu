import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/menu_controller.dart' as app_menu;
import '../../../core/theme/app_theme.dart';

class MenuFilterView extends GetView<app_menu.MenuController> {
  const MenuFilterView({Key? key}) : super(key: key);

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
        title: Text(
          'Filters',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Price Range'),
                    SizedBox(height: 16.h),
                    _buildPriceRangeSlider(),
                    SizedBox(height: 24.h),

                    _buildSectionTitle('Sort By'),
                    SizedBox(height: 16.h),
                    _buildSortOptions(),
                    SizedBox(height: 24.h),

                    _buildSectionTitle('Categories'),
                    SizedBox(height: 16.h),
                    _buildCategoryOptions(),
                    SizedBox(height: 24.h),

                    _buildSectionTitle('Dietary Preferences'),
                    SizedBox(height: 16.h),
                    _buildDietaryOptions(),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Obx(
      () => Column(
        children: [
          RangeSlider(
            values: RangeValues(
              controller.minPrice.value,
              controller.maxPrice.value,
            ),
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.divider,
            labels: RangeLabels(
              '\$${controller.minPrice.value.toInt()}',
              '\$${controller.maxPrice.value.toInt()}',
            ),
            onChanged: (RangeValues values) {
              controller.minPrice.value = values.start;
              controller.maxPrice.value = values.end;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${controller.minPrice.value.toInt()}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${controller.maxPrice.value.toInt()}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOptions() {
    return Obx(
      () => Column(
        children: [
          _buildRadioOption('Popularity', 'popularity'),
          _buildRadioOption('Price: Low to High', 'price_asc'),
          _buildRadioOption('Price: High to Low', 'price_desc'),
          _buildRadioOption('Rating', 'rating'),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title, String value) {
    return InkWell(
      onTap: () => controller.sortBy.value = value,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: controller.sortBy.value,
              activeColor: AppColors.primary,
              onChanged: (val) => controller.sortBy.value = val.toString(),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryOptions() {
    return Obx(
      () => Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children:
            controller.categories.map((category) {
              final isSelected = controller.selectedCategories.contains(
                category,
              );
              return GestureDetector(
                onTap: () => controller.toggleCategory(category),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.divider,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color:
                          isSelected ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildDietaryOptions() {
    return Obx(
      () => Column(
        children: [
          _buildCheckboxOption('Vegetarian', 'vegetarian'),
          _buildCheckboxOption('Vegan', 'vegan'),
          _buildCheckboxOption('Gluten-Free', 'gluten_free'),
          _buildCheckboxOption('Dairy-Free', 'dairy_free'),
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(String title, String value) {
    return InkWell(
      onTap: () => controller.toggleDietaryPreference(value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Checkbox(
              value: controller.dietaryPreferences.contains(value),
              activeColor: AppColors.primary,
              onChanged: (_) => controller.toggleDietaryPreference(value),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
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
          Expanded(
            child: TextButton(
              onPressed: () => controller.resetFilters(),
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(color: AppColors.divider),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                controller.applyFilters();
                Get.back();
              },
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 14.sp, color: AppColors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
