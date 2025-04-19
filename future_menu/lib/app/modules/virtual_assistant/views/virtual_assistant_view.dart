import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/virtual_assistant_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/layouts/main_layout.dart';

class VirtualAssistantView extends GetView<VirtualAssistantController> {
  const VirtualAssistantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentRoute: Routes.VIRTUAL_ASSISTANT,
      title: controller.currentStep > 0 ? 'Step ${controller.currentStep}' : controller.restaurantName,
      actions: [
        Obx(() => controller.currentStep > 0
            ? TextButton(
                onPressed: controller.skipQuestions,
                child: Text(
                  'Skip question',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
              )
            : SizedBox.shrink()),
      ],
      child: Obx(() {
        if (controller.currentStep == 0) {
          return _buildWelcomeScreen();
        } else {
          return _buildStepScreen();
        }
      }),
    );
  }

  Widget _buildWelcomeScreen() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            'Let\'s find the perfect dish for you',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 30.h),
          // Virtual Assistant Option
          _buildOptionCard(
            title: 'Choose Virtual Assistant',
            description: 'Simplify your decisions through our Smart Menu',
            icon: 'assets/icons/assistant.svg',
            showArrow: true,
            onTap: () {
              controller.setStep(1);
            },
          ),
          SizedBox(height: 20.h),
          // Go to Menu Option
          _buildOptionCard(
            title: 'Go to the menu',
            description: 'If you already know what to order, this is the best choice',
            icon: 'assets/icons/menu_icon.svg',
            showArrow: true,
            onTap: controller.goToMenu,
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildStepScreen() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Text(
            'How are you feeling right now?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Select all that applies:',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1,
              children: [
                _buildFeelingCard('Thirsty', '🔥'),
                _buildFeelingCard('Hungry', '😋'),
                _buildFeelingCard('Tired', '😴'),
                _buildFeelingCard('Angry', '😠'),
                _buildFeelingCard('Bored', '😐'),
                _buildFeelingCard('Sick', '🤒'),
                _buildFeelingCard('Energized', '⚡'),
                _buildFeelingCard('Other', '🔍'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Container(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: controller.nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.MENU);
              },
              child: Text(
                'Take me to the menu',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildFeelingCard(String feeling, String emoji) {
    return Obx(() {
      final isSelected = controller.selectedFeelings.contains(feeling);
      return GestureDetector(
        onTap: () => controller.toggleFeeling(feeling),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                feeling,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildOptionCard({
    required String title,
    required String description,
    required String icon,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.w,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textSecondary,
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }
} 