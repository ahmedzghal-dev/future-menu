import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/menu_controller.dart' as app_menu;
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/layouts/main_layout.dart';
import 'menu_filter_view.dart';

class MenuView extends GetView<app_menu.MenuController> {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentRoute: Routes.MENU,
      title: controller.restaurantName.value,
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list, color: AppColors.textPrimary),
          onPressed: () => Get.to(() => const MenuFilterView()),
        ),
      ],
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            margin: EdgeInsets.only(top: 20.h, bottom: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Choose the best dish for you',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.tune, color: Colors.orange),
                        onPressed: () => Get.to(() => const MenuFilterView()),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.divider),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.divider),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildCategoryTabs(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(() {
                final items = controller.filteredMenuItems;
                return ListView.builder(
                  itemCount: items.length,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemBuilder: (context, index) {
                    return _buildMenuItem(items[index], index);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(top: 16.h),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final isSelected = category == controller.selectedCategory.value;

            return GestureDetector(
              onTap: () => controller.changeCategory(category),
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, int index) {
    int itemId = index + 1; // Simple mapping of index to ID for demo

    return InkWell(
      onTap: () {
        controller.openFoodDetail(itemId);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SvgPicture.asset(
                item['image'] as String,
                height: 80.h,
                width: 80.h,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item['description'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: AppColors.secondary,
                        ),
                        onPressed: () => controller.addToCart(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
