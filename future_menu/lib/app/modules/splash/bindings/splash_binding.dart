import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('SplashBinding: dependencies() called');
    // Use put instead of lazyPut to ensure controller is created immediately
    Get.put<SplashController>(
      SplashController(),
      permanent: false,
    );
  }
} 