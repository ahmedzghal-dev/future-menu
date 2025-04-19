import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('AuthenticationBinding: dependencies() called');
    // Use put instead of lazyPut for immediate initialization
    Get.put<AuthenticationController>(
      AuthenticationController(),
      permanent: false,
    );
  }
} 