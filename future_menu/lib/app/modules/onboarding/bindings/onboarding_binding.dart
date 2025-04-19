import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('OnboardingBinding: dependencies called');
    Get.put<OnboardingController>(
      OnboardingController(),
      permanent: false,
    );
  }
} 