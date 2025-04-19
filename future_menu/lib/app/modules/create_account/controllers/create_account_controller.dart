import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class CreateAccountController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final RxBool isPasswordVisible = false.obs;
  final RxBool isFormValid = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Check if an email was passed from the previous screen
    if (Get.arguments != null && Get.arguments['email'] != null) {
      emailController.text = Get.arguments['email'];
    }
    
    // Add listeners to all text controllers
    usernameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }
  
  void _validateForm() {
    isFormValid.value = usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 6;
  }
  
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  
  void createAccount() {
    if (isFormValid.value) {
      // In a real app, this would send the data to a backend
      // and register the user
      Get.toNamed(Routes.VERIFY_CODE, arguments: {
        'email': emailController.text.trim(),
      });
    }
  }
  
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
} 