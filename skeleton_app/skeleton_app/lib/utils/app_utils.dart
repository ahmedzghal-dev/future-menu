import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  // Show a loading dialog
  static void showLoading({String message = 'Loading...'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Hide the loading dialog
  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  // Show a snackbar message
  static void showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red.withOpacity(0.7) : Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
    );
  }

  // Format date to a readable string
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 