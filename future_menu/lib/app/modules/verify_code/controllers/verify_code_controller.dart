import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class VerifyCodeController extends GetxController {
  // Create text editing controllers for the digits
  final TextEditingController digit1Controller = TextEditingController();
  final TextEditingController digit2Controller = TextEditingController();
  final TextEditingController digit3Controller = TextEditingController();
  final TextEditingController digit4Controller = TextEditingController();
  
  // Focus nodes for each digit field
  final FocusNode digit1FocusNode = FocusNode();
  final FocusNode digit2FocusNode = FocusNode();
  final FocusNode digit3FocusNode = FocusNode();
  final FocusNode digit4FocusNode = FocusNode();
  
  final RxString email = ''.obs;
  final RxBool isCodeValid = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Get the email from the arguments
    if (Get.arguments != null && Get.arguments['email'] != null) {
      email.value = Get.arguments['email'];
    }
    
    // Add listeners to validate the code
    digit1Controller.addListener(_validateCode);
    digit2Controller.addListener(_validateCode);
    digit3Controller.addListener(_validateCode);
    digit4Controller.addListener(_validateCode);
    
    // Add listeners to move to the next field
    digit1Controller.addListener(() {
      if (digit1Controller.text.length == 1) {
        digit2FocusNode.requestFocus();
      }
    });
    
    digit2Controller.addListener(() {
      if (digit2Controller.text.length == 1) {
        digit3FocusNode.requestFocus();
      }
    });
    
    digit3Controller.addListener(() {
      if (digit3Controller.text.length == 1) {
        digit4FocusNode.requestFocus();
      }
    });
  }
  
  void _validateCode() {
    final digit1 = digit1Controller.text;
    final digit2 = digit2Controller.text;
    final digit3 = digit3Controller.text;
    final digit4 = digit4Controller.text;
    
    isCodeValid.value = digit1.length == 1 && 
        digit2.length == 1 && 
        digit3.length == 1 && 
        digit4.length == 1;
  }
  
  void verifyCode() {
    if (isCodeValid.value) {
      // In a real app, this would verify the code with a backend
      Get.offAllNamed(Routes.HOME);
    }
  }
  
  void resendCode() {
    // In a real app, this would resend the verification code
    Get.snackbar(
      'Code Resent',
      'A new verification code has been sent to ${email.value}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  @override
  void onClose() {
    digit1Controller.dispose();
    digit2Controller.dispose();
    digit3Controller.dispose();
    digit4Controller.dispose();
    
    digit1FocusNode.dispose();
    digit2FocusNode.dispose();
    digit3FocusNode.dispose();
    digit4FocusNode.dispose();
    
    super.onClose();
  }
} 