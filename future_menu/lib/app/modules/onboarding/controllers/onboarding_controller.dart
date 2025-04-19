import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../authentication/controllers/authentication_controller.dart';
import '../../authentication/bindings/authentication_binding.dart';

class OnboardingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint('OnboardingController: onInit called');
  }

  void goToAuthentication() {
    debugPrint('OnboardingController: goToAuthentication called');
    try {
      // First, make sure the AuthenticationBinding is applied
      AuthenticationBinding().dependencies();
      Get.offAllNamed(Routes.AUTHENTICATION);
    } catch (e) {
      debugPrint('Error navigating to authentication: $e');
      // Try using toNamed instead
      Get.toNamed(Routes.AUTHENTICATION);
    }
  }

  void skipOnboarding() {
    debugPrint('OnboardingController: skipOnboarding called');
    try {
      // First, make sure the AuthenticationBinding is applied
      AuthenticationBinding().dependencies();
      Get.offAllNamed(Routes.AUTHENTICATION);
    } catch (e) {
      debugPrint('Error navigating to authentication: $e');
      // If HOME isn't set up yet, handle it gracefully
      showDialog();
    }
  }

  void showDialog() {
    Get.defaultDialog(
      title: "Navigation Error",
      middleText:
          "The next screen is not available yet. This is just a UI demo.",
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
