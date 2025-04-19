import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme_service.dart';

class ProfileController extends GetxController {
  final ThemeService _themeService = Get.find<ThemeService>();
  
  // Observable variables
  final RxString userName = "John Doe".obs;
  final RxString userEmail = "john.doe@example.com".obs;
  final RxString userPhotoUrl = 'https://via.placeholder.com/150'.obs;
  final RxBool isDarkMode = false.obs;
  
  final int totalQRCodes = 12;
  final int totalScanned = 28;
  final String appVersion = "1.0.0";
  
  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _themeService.isDarkMode;
  }
  
  // Toggle between light and dark theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _themeService.switchTheme();
  }
  
  void editProfile() {
    Get.snackbar(
      'Edit Profile',
      'Feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void openNotifications() {
    Get.snackbar(
      'Notifications',
      'Feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void openPrivacy() {
    Get.snackbar(
      'Privacy',
      'Feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void openHelp() {
    Get.snackbar(
      'Help & Support',
      'Feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void signOut() {
    Get.dialog(
      AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(AppConstants.authRoute);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
  
  void logout() {
    signOut();
  }
} 