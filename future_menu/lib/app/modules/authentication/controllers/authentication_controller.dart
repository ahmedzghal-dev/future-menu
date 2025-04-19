import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class AuthenticationController extends GetxController {
  void signInWithEmail() {
    // Navigate to email verification screen
    try {
      Get.toNamed(Routes.EMAIL_VERIFICATION);
    } catch (e) {
      showDialog("Email verification screen is not available in this demo");
    }
  }
  
  void signInWithFacebook() {
    // In a real app, this would authenticate with Facebook
    try {
      Get.offAllNamed(Routes.RESTAURANTS); // Use RESTAURANTS instead of HOME
    } catch (e) {
      showDialog("This is a UI demo only. Facebook authentication is not implemented.");
    }
  }
  
  void signInWithGoogle() {
    // In a real app, this would authenticate with Google
    try {
      Get.offAllNamed(Routes.RESTAURANTS); // Use RESTAURANTS instead of HOME
    } catch (e) {
      showDialog("This is a UI demo only. Google authentication is not implemented.");
    }
  }
  
  void skipSignIn() {
    // Skip sign in and go to restaurants screen as a guest
    try {
      Get.offAllNamed(Routes.RESTAURANTS); // Use RESTAURANTS instead of HOME
    } catch (e) {
      showDialog("This is a UI demo only. Navigation is not fully implemented.");
    }
  }
  
  void showDialog(String message) {
    Get.defaultDialog(
      title: "Navigation Info",
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      }
    );
  }
} 