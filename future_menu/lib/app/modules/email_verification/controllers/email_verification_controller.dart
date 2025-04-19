import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class EmailVerificationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxBool isEmailValid = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateEmail);
  }
  
  void _validateEmail() {
    final email = emailController.text.trim();
    // Simple email validation
    isEmailValid.value = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$').hasMatch(email);
  }
  
  void submitEmail() {
    if (isEmailValid.value) {
      final email = emailController.text.trim();
      // In a real app, this would send the email to a backend
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: {'email': email});
    }
  }
  
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
} 