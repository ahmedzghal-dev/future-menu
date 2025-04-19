import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';

class AuthController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  
  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    phoneController.clear();
  }
  
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      
      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulating API call
        
        // For demo purposes, always succeed with login/register
        Get.offAllNamed(AppConstants.homeRoute);
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
  
  Future<void> login() async {
    if (!validateLoginForm()) return;
    
    isLoading.value = true;
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Store token (mock for now)
      await _prefs.setString(AppConstants.authTokenKey, 'mock_token');
      
      // Navigate to home
      Get.offAllNamed(AppConstants.homeRoute);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> register() async {
    if (!validateRegisterForm()) return;
    
    isLoading.value = true;
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Store token (mock for now)
      await _prefs.setString(AppConstants.authTokenKey, 'mock_token');
      
      // Store user data (mock for now)
      final userData = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };
      
      await _prefs.setString(AppConstants.userDataKey, userData.toString());
      
      // Navigate to home
      Get.offAllNamed(AppConstants.homeRoute);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  
  bool validateLoginForm() {
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return false;
    }
    
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }
    
    return true;
  }
  
  bool validateRegisterForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your name');
      return false;
    }
    
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return false;
    }
    
    if (phoneController.text.isEmpty || !GetUtils.isPhoneNumber(phoneController.text)) {
      Get.snackbar('Error', 'Please enter a valid phone number');
      return false;
    }
    
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }
    
    return true;
  }
  
  void forgotPassword() {
    // Navigate to forgot password screen
    Get.snackbar('Info', 'Forgot password functionality will be implemented soon');
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
} 