import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../modules/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';

class SplashController extends GetxController {
  // List of all available routes for navigation
  List<Map<String, dynamic>> get availableRoutes => [
    {'name': 'Splash', 'route': Routes.SPLASH},
    {'name': 'Onboarding', 'route': Routes.ONBOARDING},
    {'name': 'Authentication', 'route': Routes.AUTHENTICATION},
    {'name': 'Email Verification', 'route': Routes.EMAIL_VERIFICATION},
    {'name': 'Create Account', 'route': Routes.CREATE_ACCOUNT},
    {'name': 'Verify Code', 'route': Routes.VERIFY_CODE},
    {'name': 'Location', 'route': Routes.LOCATION},
    {'name': 'Location QR', 'route': Routes.LOCATION_QR},
    {'name': 'Location Manual', 'route': Routes.LOCATION_MANUAL},
    {'name': 'Restaurants', 'route': Routes.RESTAURANTS},
    {'name': 'Virtual Assistant', 'route': Routes.VIRTUAL_ASSISTANT},
    {'name': 'Menu', 'route': Routes.MENU},
    {'name': 'Food Detail', 'route': Routes.FOOD_DETAIL},
    {'name': 'Recommendation', 'route': Routes.RECOMMENDATION},
    {'name': 'Rewards', 'route': Routes.REWARDS},
    {'name': 'Cart', 'route': Routes.CART},
    {'name': 'Order Status', 'route': Routes.ORDER_STATUS},
    {'name': 'Checkout', 'route': Routes.CHECKOUT},
    {'name': 'Add Card', 'route': Routes.ADD_CARD},
    {'name': 'Payment Success', 'route': Routes.PAYMENT_SUCCESS},
    {'name': 'Feedback', 'route': Routes.FEEDBACK},
  ];

  @override
  void onInit() {
    super.onInit();
    debugPrint('SplashController: onInit called');

    // Use a simpler approach with less overhead
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _navigateToOnboarding();
      });
    });
  }

  void _navigateToOnboarding() {
    debugPrint('Attempting navigation to onboarding');
    try {
      Get.offNamed(Routes.ONBOARDING);
    } catch (e) {
      debugPrint('Error during navigation: $e');
    }
  }

  void navigateTo(String route) {
    try {
      Get.offNamed(route);
    } catch (e) {
      debugPrint('Error navigating to $route: $e');
      // Show error message
      Get.snackbar(
        'Navigation Error',
        'Could not navigate to the requested screen',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
